Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305232B121
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020413; cv=pass; b=KS7/A/9g1JTX9FNWrKRwFjHhKA5NaNkMfjsl4xhtGYObvUZPmoQRpQbcUmNc6fuQZgfFuV76WxUkwLM80gd95hZZREDbXfXM1EQLL0qdAmbGW47PzJEe+UYJBr6usKgv4N0rNzYjniYHOBYx18NGGefoqyPT+sFJgisM3+dAErc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020413; c=relaxed/simple;
	bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwB6u9TgbQfNxOSPA891fJ4YwRwqU+Rb2dnFEB2Hu3AtZpbbS0LYUunky2GzYrRsXRX1qcV5RUBoqNDOD+DFVuvlc8hJxeOlLpIwnnZCdqpCh2PDtSqN+qnSdILdZ319GAI9EoWBBae1QmD2Nabfr4OIu0zyR4Y+X/8Q4Vn5GNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osBm2kkJ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osBm2kkJ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01089e8aso5582921cf.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020410; cv=none;
        d=google.com; s=arc-20260327;
        b=dbqUi38snazoM8cu7f45T7gFtKexKvknH7u9lOqSRfkD3IiBx+3dxxNdmGAszs4sus
         cijAGOFNijkUIlpIqku1Pmr8b2hRgDvp+3gAvI4MWtwWGr8sZPb0OVr34Rsa8DvssllR
         CyvxnG/DJ5QkLbM8qnAeic455AcbxhW0jnlCvXYjZ30+QTeRfCbHNa4kO33R3tD/lBMU
         2z+lpC+GOA2SpAohnu9saKgqPzF7yWsn46hb7Hu1uz+kP1MCmEMr00Uue5RKyUSgX3bf
         j/y6E60BfQkTZQOFQa7fKQaKHubxTtExG/qZR/6GQ6730msJ+ZRZBNVPQHp43dgDCWOu
         JnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        fh=fxItc/IfTPZqTGOiJ+C/QzAxpOoVQPrUHqy5dDrQBSg=;
        b=YHldhTZYsC5q6CEk+UjlddAl1X5IdKgsq6MPRZQYyo4M9RBtCWRdCtAEV+Y++AC/Ub
         xmVL5CXmzMlibws2w2k4Ckg+q7Xc24ZZrdtJANuhJ5rYpwZvt7q/bJwW7W3IW94Q0uxe
         t79Nk5BNGDagfgJAFglokGOkHMP/EXcwweF4N9zInW4BJNt3YrcOaJyrlucuQxpykZBM
         i0eWTiSE9f9VHost5zSPjOtvjViuAwTyJatEeefuP95PRtr2lDe5hKFKKCWCZmOFLFLz
         ckVeXPzIBW9JMqZE30gsXJ+QlY5Py5QY058IyeXvlL5EunGZmjYAY90FCYPt8/SPqfnu
         ijGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020410; x=1784625210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        b=osBm2kkJg/gCtOqVsfksOghu+G5PaV9udJNjYSZUi2ALQ4BBb4Ks2DKa7K2iG4og2C
         p4iOsjNr+v/KS6olVLpSZr/PW3bepOevuYCMmlzTVDAqlNFotiuDPyz4jCGM/UUmrOn3
         NY1vX43j2mQgoE58GqLTB5KWGzx9/qenuc+cSdvyXOynEITmsYfkHGm7QMLtD5V5A0/x
         IuYnAL6NmpUlCL4Mrfr7WPlb1ThCiZLvk5GlRjbwNDOyEnlWwnNUn8BIq29TkJS98N64
         jGRu6x8kJ/uCilwitKF1ZHJB5NJTkAywkNUQjnWseI7GN8KAvvBfVfWBYRyL1WuEj+33
         DdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020410; x=1784625210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        b=lB0Om3IH6NjbGTpuyTsTo4Ijf66rB6dNM1THSb9ZedQtFcVHWITLoJVcLRRd9HX0MD
         kU7Xqw1wj2ZMozMWIW7iWeCddUtzPi55UmqBZmzF3KoDbKafL9US2tuunQyVxlFNdzT5
         dPmkCIAMci2a3X0yp/2zLK4EHxOrbQ86ofS4eE7du2lT1k286F1olrlaPB6YuWd7Nbbm
         kRMRWF363xMkAK3/MQ5QAk2BC7UgYUDloeFyXQiKj1kxS7VhB1Sk7lgB+fKwJEo8pb3p
         GbXqWss9aGcYNAHdphpedVxAsVqOyTp75gU4Tq43CI70JL5mp/kLyOB/ahcJpzp0xZu0
         XQ/A==
X-Forwarded-Encrypted: i=1; AHgh+Rrui/bRZdL6SGZZVE23ZLFtAKD22a5kWQjZSVTpPEbVgFaaggN0O3jHIYjwTi2/3pmpzNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWH6amN/AjP/Dl6Q5h7IhD04mFODRnJMFc0LkSNS3Gb48xM0G
	9PDRH6pPjoyuCUwFIavQ9ZwoVt+90MLheNHOzUABo34llA9Fgi35MOx57SB+1E7eKKaLXYOFBnd
	I28wplAAUFAE/8Q64HxDx35HjWa/cWKd84QEvkVHW
X-Gm-Gg: AfdE7cnTAM2TQ1U7RsBU94v7RoTGihzzP/oNiwmEh5bA7ujo+k/5xm03TBq+yFtJFKf
	uAKXT9uhYOkv05zb+2gP+sHDZw3HoecLOoTAR0n1dYnl2IzM8teInyt7f4Z+lelCpibTceD3HWs
	1AHnvYcCgbpH1Y8ar8zeQqjvJ8Co5XBPeZIE1Nhb7yf6ovRSjkaBWk1ipdHA4TkbJil+K3x1Mx8
	hP7TQazvNHUkZ6lNuTkE5X4oL1EYHhVx62yiqbIYpkf3PJyoVhwIis6g6+TPNgTLHfDhtfN/n+k
	zKgEyf1QxgTpliu3Td/uQY66aI65Z3BgQA9UJy+Wrp3ScCa8euUvU8LosULluHDPhM3jQrAa/Na
	JQ2WWjr2Wo78=
X-Received: by 2002:ac8:5710:0:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-51cbf05b838mr114112991cf.12.1784020409735; Tue, 14 Jul 2026
 02:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713233230.3553593-1-xmei5@asu.edu>
In-Reply-To: <20260713233230.3553593-1-xmei5@asu.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jul 2026 11:13:18 +0200
X-Gm-Features: AVVi8CdUge_r3MDnwBk1ze871ePVoddpU4H15_irkbqp4L3bN6ocl-OjeezJpG8
Message-ID: <CANn89iJsDMJR_hLyENfrfjmD3ttt-b6WibrPHK+hHQVWra85yg@mail.gmail.com>
Subject: Re: [PATCH net] bpf: tcp: fix double sock release on batch realloc
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jordan Rife <jordan@jrife.io>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:32=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu.ed=
u> wrote:
>
> bpf_iter_tcp_batch() releases the current batch via
> bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
> each slot with the socket cookie, then grows the batch. cur_sk/end_sk
> are kept for bpf_iter_tcp_resume(), but on realloc failure the function
> returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
> slots that now hold cookies rather than sock pointers.
> bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
> dereferences a cookie as a struct sock.
>
> Empty the batch on the failure path so stop() does not release it
> again. The sockets were already freed by the first
> bpf_iter_tcp_put_batch(), so nothing leaks, and a later read() rescans
> the bucket from the start instead of skipping it. The sibling
> GFP_NOWAIT failure path still holds real socket references and is left
> for stop() to release.

Reviewed-by: Eric Dumazet <edumazet@google.com>
