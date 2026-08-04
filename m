Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD94756AD
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865849; cv=pass; b=L1XzRaRCD0wCqjJkGyFVO7Q9XqumpLjoX3HdQ26Y73UG2ji7Uv0gcPfnnC0Oo5NPmt16vMJQjl2pAe2aYk14rm5uLOjtJxJ4TJUePjftS7rH/l3LopSuHylvMGGiU4wOSgqoKVbEUoawXOl3nMdWahc7FXWTwNLidNtW1u9suYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865849; c=relaxed/simple;
	bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScBDjBCCTt9FlW2vOH/xH2WNuOM1M8cFXb67cmMfKpDDg90dEqPaWitE97C1CziH6qqDBf6EYsYlyoKZ8NOVc06ZA6CibkW8t9U8m2fVQBNzKuvspxX2CwVaWJLH8lqZifG8mrPpQSCJdfyJgjXXxSQMyGJwWrx4nZFxiONNLFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WP6Qbi+4; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WP6Qbi+4"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso33309a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865843; cv=none;
        d=google.com; s=arc-20260327;
        b=cRAcAFrCeY0A3R+rrAyPCO0YaEbTSSi0joc1trVWznqYJB1WKvdcMNVEzSi9o5nwvg
         sDP34OePy9o49VKMVLp4Bf8JM1rl3WVq2u+xZJjHu1L3nU3FeIjIbrgxC0zAx1582Nwm
         QBpFtXtfM/6fFYbph9dqCgvCFmtkFd1MtssZS0qRjJpHHyf7To2gLtYeCFCcaFXNas2V
         jft3T49aeLTe60gkRYsZBYBvGdBC/B/kRv+MHAe7rTPZZEvwUIrckrE7yvxE2+lwXWto
         TccmtOSwah5Eo/YxGkerJE3CBPUIBK9BOFrcj/o/N4nS5s+Er2vM9zgpwFCK5fW2tSij
         y4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        fh=l9uZ5+zClkcd4MriGcZSZZAE00taDnkaXXEGtc6aztY=;
        b=H7AEzXUdRvDejPhffxbgOyCqH1bdX2lkEKBvyWMIksUOVz5Xh3mezYrV7hhKR6n1D2
         WGrPxfh5nHy564XJrrdc3DuzmyWxAGv7NTHRxx97B79KlI9Mb8nu+wuJjKtns0OhqSy4
         KjrBUSFULErTjLEWIFpaWYTIFtbrqu4Qc4dCXpE/TJjkS0Cuf4HRvNFKb6b6g6vbLY6/
         dHyCjgVcKJctvkDzoPosPgyQA9xG6Oi5oWMl0/rcaQZxr0+G9j+5jFvvd1k1f5nqXAAq
         R7ulyqeIMxC4IaQRqx4199euexa+6Lq8H7U4vTh8gT2eeZI2Urb0h6qKGHTTLAujXph2
         WkGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785865843; x=1786470643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        b=WP6Qbi+4FiXr0AGfHsHJcun3ykEqeDDKqZUz0V0sSU5RRdvukB2Hz6Nx7xJcx1srMZ
         AaVlcH3LDa8uvcK+T/nG3ZsXdrY5l8R8vopI1lYtYA+EOmLvAyJiesrHP0d+TbVdxwQV
         NYnk/J4zbXeJZkCcoJpatD9LmZEFY8mk3rpZ6U9AuphERRmJjGLE7jWS3inSXmvTBwK+
         wjHHh9NiL7HQU+zyY8qOaNtkyR/K9SoEh+9y+MIByDmpC4VvPg2YO0SAybXNqJoZZU0R
         jjZabjNvvXT6PxU6PAPWpaDuQHme5AfRWd236EnrHFr45qgTR0TcPHaZ6z++Tjy4al2T
         8TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865843; x=1786470643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2NoB8UxuFC82OzSlOcl1wpNUAMS7Ej/m/OzlePuNhg=;
        b=ARIYG/ANAabW7bxAGTePHT+DwWlbZEOy0h6YmvM5aNd9ViZhd3YgrB1AvXTfaTZPQd
         izCTe5mZKIhC0z7gJntUIwaiXJoA78toZa0o3MTBuLhwgodqBmdkmZFosMDkZh1I9pk1
         NcQOucxwdSBoFAfKRlR1Fz8b0ZzCCpdyTQTu1to9uHJzzFFMcF4w5wsj+qiKq94AU4Mq
         iaRFo0WXX2eIBO63TW8pus82qSVT7IgmpuT5T1yrBAsoyj0riksclX/oQr/nohrCJfFH
         un7EoGMxr0TME/Co0iluG/zitFDj7ULd1yPBX7zaBl0X1xEtZR2M0kcDHXY91qgzGJMb
         Ntmw==
X-Gm-Message-State: AOJu0YxzBhNCDwGibaET4dnwojwpYVoXmUFtO3/R9Q/MxNNoVo+6nmeQ
	CWlECcNoF7QDHy9fgevYZ+1fSRWh7dqTF0PHLiuruDRjd23A40S04UeaP4TyYzfdQys/k+WSZoY
	8CitwJBYLuI5in649O9dlbEccNjoWbfRuirKbXe1X
X-Gm-Gg: AR+sD12mGy2RvNXznult8vGzfFl1LyBVXJx67k6/XBlwro8UiJxAMgPq1i0BSUXj2M+
	EcO/1KpgDie9kyI/BIPk1o4aX8HYoED0ZrQgkcFnZBSC49dEcLpCcs54j0n58fCNY9GAMeiahrL
	+VzxxGpUZiqNvANb7AUM4G4RZukjqvx4qQbiqcmVnjt/7SZowFMOSdF3gJ/lfqmMFOUp28tmqJv
	EndIZ85RCYn0yAigvx6ywGYr1Z2SLeLV/sgMrHcxLV5wp3AZ1LYg5aicz3cy7pI5jOR2TdWQB0V
	phsdumRrOtTgj3Fkl2qItOWQ8GPZHg49CGLQlhDc6Tu0eMgYrLcZ02UB9wUP3LXUHnFkiEX70fk
	j7cDP7JL1s6Mk5aMCwnPM5FsPG0MpZWbSbEHy4izKaoKDWQqxgYgsWOPNfKoioG4RYZfeWXLFcJ
	8o54aiifGgwOhOARBVRcJfcg==
X-Received: by 2002:a05:6a20:da12:b0:3b4:75c0:3ec0 with SMTP id
 adf61e73a8af0-3cb85ea6f79mr547484637.30.1785865842460; Tue, 04 Aug 2026
 10:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785823138.git.rakukuip@gmail.com> <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
In-Reply-To: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:50:31 -0700
X-Gm-Features: AUfX_mzr88BizKCiqpMcqwp6xAE5qqUYy8SkO6a6S0U9m0_75sI1TYtqbRNzRI0
Message-ID: <CAAVpQUCg12BzowmXZuY5Agz1PCSdT+tCrqSpkNMfkkvDJv-KWQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
To: Ren Wei <enjou1224z@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lmb@cloudflare.com, 
	ppenkov@google.com, vega@nebusec.ai, rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:29=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
> 'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they acce=
ss
> sk->sk_protocol without validating whether 'sk' represents a full socket.
>
> When a BPF program passes a mini-socket (such as struct request_sock or
> struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
> is located beyond the memory boundary allocated for mini-sockets.
> Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
> kernel read.
>
> Fix this issue by checking sk->sk_state !=3D TCP_LISTEN before inspecting
> sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie=
.
> Since mini-sockets are never in the TCP_LISTEN state, the condition
> short-circuits and prevents dereferencing fullsock-specific fields.
>
> Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
> Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
