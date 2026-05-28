Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461183F8ED8
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980918; cv=pass; b=lLkp7AIuRxOfEBD1/fnuKKqplOeFNoUyLNOGzyU9nSUYQtkBfPmyajg2mq54Lp6eEpECe4A5P6pO5q80Tx8xg/Zqpa5oPsxXfw11B6qieWmnF6FB3rqVTg0D/1VAQhk0nejqCy3yIRyqBShIQbB1A0PnURy/mnguik477FwnrX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980918; c=relaxed/simple;
	bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fAdqGVclhWq0qSfDyiD4RmoA8DhGDpBbApWXQhKr5ev+sqN6A0cfYQtxaMswPpJG3b03eFUfPm/tZNRmwKAJPMlIJ3IdGRzLd2JnDz5LFDbfJQtmVdJqUa2uZWtubtTXbEopINBjsqB4sFMNvB9bkyWNvkDe3Vr2g0XkeQ5nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waiMAjKM; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waiMAjKM"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-57513ac61f0so4190767e0c.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 08:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980910; cv=none;
        d=google.com; s=arc-20240605;
        b=B0a4+6ATQydgbFvA1V/oGJ8fAT9qAItsBwn14HZE+YkunYuikEsvqXpx8C0DSRQQ9K
         VtX1i1WSI9zaQ4WGK06GrbkFpDxxIPzX5T9M61eYzPn//+DJOKF4h2E6x7utxgd/PRl0
         Q8HrTALk0a4pLDspd5/7s0EWnbnegU/djf9ni7E5iJRSXyh6DQvr63fLJmJ6F3jHxjl/
         93wbmRcyZfX/h0N1oDkpExKfd3VadYV/AqZggDog1zxLZGnG4fjbOEZPXQj+7RY0EbCc
         bTdZwV4sdAmCl6CZqG6K62+0CD2WDLUvPM56IsVekZg12ZsmZPmS7GGjBNwkWXbsawUn
         ECeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        fh=DkinGtahbS23YQnCoFAfAoxU/RXKXCQtzuB9vfnpK4s=;
        b=SQD9J6IQ4h3kKKT3/ZnqA3LYZcboxMGYCyTb8CJ8GmXIyrrH6AM9LyLwG83Ds00cWr
         wwqvh9fBYtDCmcSFBlUdMxPNouDiiyU64DXvFNZaVJBvmDr2t67kSd8PoSgkwIwM7pyR
         Jvykp2qqEwIhP2gt4iZCQmInQX7fMJAOd51EagIWB0dnA99ZmdL1Hf587z+mqWTJSNZN
         hjErhHZkdInS89Q9QHr5lHVLfreCuPCzkzAyxSY30K0IPK4Mv/wkZz48vCEHZV07X/lM
         xppJIQWE4QmzHLlNgp3iQvbjsu/UzoaHJ1HR6FBV4TWBWfE+De9230TfYZe6fmYa34nB
         kPhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779980910; x=1780585710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        b=waiMAjKMyMQ/F0gq/JN3nYu8tMGRuRr2b2omRFKXVPVlZOV+k27aBAO3KDzxkW8GlI
         1X14PJjsWyBR89t95KvIr9gQeWtgfvecUZxFDrsHDnJTSH73ZN8XuMcy47nwygk8vKHA
         gvxxJn/9DKWCbbdk5dFYw7I/o5azwQtBdbtm8unAgOEon42OYez3fgyN2/aQTpJJk3eM
         IfO7nD8z9ytSM5z+Dv4FmDdOwekmrwksMGS49DIyC9vJ8496+SNA1QrxRAhrWpL4TNEG
         1JrqrTw7lZnrWa39U3vXcUW49+WXT4+tUURREVVyvsBW6nSY71TYu/oMkiXWfjDBNtLB
         19dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980910; x=1780585710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        b=jYC4VinCWWfuRhauvYI9Il2K+sV8PWzc7OHDD1lfQQDhRQJLfwhnwY9otnm2r0Uq34
         40sGCqNrrHHLv14jZWpba/lBQ5Fj/YP+DpaB6hS90eTXW5CrGQxGKu8L3TD3j1SO9nKC
         WnnSJwajRvWlT8Rmuiz3fiCal2SRoOhUtcIx6tzVCEXsLM5Xm2cK9vTsixI/2vvWxgVX
         stzxy3gY7D4UpG8Kq4EzAOE6Y86PvN8PL9RA8KfKfaOhpftpxqETLD2TVRlC8lZ3vHMn
         /p4iXm0CN/7aka7RPFMUCrU3jQ8enbiRE/udIxTIf2M4tc33mzY1jbNKmMkMPPcm6XFd
         dElg==
X-Forwarded-Encrypted: i=1; AFNElJ+fB7Qg9wIB3iRmv+U+Nlv+tjwnoiG9WjYRW/QvJ4cjDet6qL5h6tFel5SdIxcAw9u15+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5aaPJLYhWKwLAi/eL2P0uiscaMtIQip8l095cRikZmiQCcxz
	wuT8SXQbEZySYfcn31PAjYTOKfq/8QY/Fcg7Y45gkI3ujhvjhQ3ysbCgu2a4GyPAn2aORQDF8N/
	OPBT2vIo0/m5IOEXd0S9yJDVLYMJVqDahcJLkatRv
X-Gm-Gg: Acq92OEq32Zoz33e4MgCbFdGk65Thad7QwNegOxAfDPzPYRkUAxlCax7Ut1c4Ju+3J9
	j/c00hQr/BZ3m6cCb/xuGleA0KB6vOZzN2Qom0MYO+owM9Wx6YkhhN70SqjnBsT7nuwt3umPJEW
	aCN1p64zkKJEzay5PgZtmHtMmUIgIOWbFcCMaWWqIMMpKyNkyxrXRfrA63yMV0oE4srGdIhsvUz
	xL3hngb97V4VT3mzPIeddv+Es6Fd0a09kwuOK7mw2Drx2XMDve0to+ZQrqom3NGAQHFL1gblIQB
	RVgOzwXBOZCQhI5wN23TsDcWiHki2byz02X/NLy9H4YTdTy/QcKV
X-Received: by 2002:a05:6122:4d89:b0:572:36f3:e792 with SMTP id
 71dfb90a1353d-5866403bae1mr13660976e0c.14.1779980909356; Thu, 28 May 2026
 08:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev> <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
 <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev>
In-Reply-To: <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Fri, 29 May 2026 00:08:18 +0900
X-Gm-Features: AVHnY4LmMjMha3LiIe968snQ7eRPeJFvP-knCBaHuX3iqopfu6QUUqbxOHtspnA
Message-ID: <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Yuyang Huang <yuyanghuang@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:37=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
> To avoid such stack corruption, you should reserve enough space for the
> query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.

That seems unreasonable. There's already a size in the bpf syscall,
why can't the kernel respect that?

Also, the length of bpf_attr has increased over time as the kernel
adds more elements. Doesn't that mean that even if the userspace
program passes a sufficient size, a future kernel could start writing
more bytes and start overwriting memory? Breaking userspace on kernel
upgrades should never happen.
