Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99BB3909A8
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126565; cv=pass; b=imjTATCG1Cpv/FEGWhoW3TQJgGkWJ7Ysnq+sxOnTyC/lY1NubBJqMKYU6glwTFxGzxASz2aH4IvE683WYrKO0OjAwCPOKmuROpA5nvHXn9YVpxqbk7TpNZdF3PlGqQBN3G2NI3gfT9/lnl3jfhVnnfG8G2h05qN63pAfK8bkh2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126565; c=relaxed/simple;
	bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7vrLvAASaDWS2xKhbIPXnNXKyUU+FT1Kicp3uRLj6Cf4H09aLMs9ds0SSY3OzNAbLxNFYtChlDONzo2iZf1rSJzeieZBaW2YbjU3bSXT9FDKB26FCLoutsj/TNYkBT+9/H8P3gG0aidGSxGmji6bjOCFMCjFuBByRK6Nvbo5dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=UyPhnG7c; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="UyPhnG7c"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac4806e210so44487607b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 21:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792126562; cv=none;
        d=google.com; s=arc-20260327;
        b=etMfKjoYZ/y02EPsVzH4UHLSLXYe/jS43Y419cw4HHLkquWMOj0DrFBUQl5L+PaLUo
         YzogmvNtpf6AcpkUUuRJLMPwKLqrlG4e7JYK8y/Qi1Lza5pp4DRmudfad5BcMb5jyO0j
         rWFnvKBmVzzuN5tRamPYNX8nel8h+IqaH2Vx+gaR6jZXsRrv53gMhU5awrVsC08CDzrM
         MYoukMs+dk4mgUTb9hllb/xt9pxN/7MdYUbHOIx1raFq3wtBRnXi4niYFdq05v7rk0T1
         7P6mtCCNlW3RICo8lNtm+sXrJAcASUyX3A39UtlAX5rsO9IBKUTn5R+VDqnp+fBRNIBz
         Z/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        fh=/ejXj8tHJNWcKGpSyf60LluppdAqTyBvQtgF0Mf+Lso=;
        b=nd9BOgi/fpwJEbIzuONjBU1TH2j7ak4BAXNDm8XCLvNiIodIJvTdLHYNQGt4j5retS
         BI0j1dGdu+TgIcDwpWelGE+sXXDRuuR769fRFM92Ww/zRUCdg6+AykQKGZ9v/UBe4ek3
         Jkpnj5PlatXmcoyvRIuyoz9WTigds8Mn4ip/TBB+xvwW2or8YJOOSynBP1jlXyVuSTYJ
         0rBtDmZkbp5AUooK+4dipqJFlgPmMbe27Fps6vGVFUlrTnrh2s4EAe9CVCYd2iYIBswo
         R77M7/udRdgm6FaYUniIekl8mZbo832JPpS6yn1dZxY64vd8NUwHbAdwYDBt0btkVztT
         22FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792126562; x=1792731362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        b=UyPhnG7cHz7RLi+YfpC1XpMlizYeO6ZG+v5wPSVqkpVwgIKftAKEcOWe1xJoaOInus
         u+13Xz9y0QfpLfvKnCYVe7ACTx7S2MIQMpTkYxvVBzTpTqtQZKVi5kAfIN7qp9PX0Jve
         2xlWyqE3u8R2CSozO6tSml0y++5LuOEr8660gKlJyqO12uyYEEjO/mVwD84qiORXGDn3
         uHRgIojTMTGHZU2zNao/FImmM4fegqyA+kMnnu63lKVdNrXPEGcn9TSZtNjGepxQbT+o
         ELauO4xt14b2GL8vFD9shYda5kEzKnQRUpd9oJvO4eJqA9M1PjbDjMqJzjxc4xYs/GXd
         Ksxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792126562; x=1792731362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHEyx5CWdu87K8jT+B4RRZF0X7+omCHa3P6e2tPw5rI=;
        b=TIKSPVkGw9IlpPjRWA167Wp0FLuS43X+TxKUG5SPHnr5W/rzbxEMnwhMCuighEKfxz
         et3+LiC0bE2IXH3btt6dpnefIpy9KW2q2LLlf1SDeRt18R9P8DyqSGYJ1lchziIei2Ub
         3ivrQ/S5dMJdnaRsDDNjO1P/Zb/GC0AVl0bcV+f8paOyReVaO0nxxhItWYPs4U0Fy5FD
         F37Pn8kpBLtktLZTjdx2TMBzrt6oJVCwje6AelBmVp1KwltxoxKKNwdkTM7l6vPTph8q
         YRKIXKbLb8Z72pWaL0Ku3OMRURzpV730pnZ4v/9LZ/Bh2qpNLlPKwX9YgI0fco3qwjuA
         4beQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhn24KXKKgy7NsUj4ygd8zm9HMZgf2Gq/jazWS31uqStTCEQRPNUFPLEGnMAK5NrYgTOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVWIp23q9yj0Ov2zAOdrnrrHuEm9JaYH/ywdxEbebr1blUrOuk
	klgDm2n6vnzs20AzFt4ya23aX71afKO8psVPNQvstbqbdOoU6ZkyMlVVyRYeg1zes6QeS38RDsn
	xJUbyx7nDHuNS3I3J5ozo7IKO6LGzQ4agQ0mNh7divTs=
X-Gm-Gg: AYBFou2wStZDn9wzSiWf3p4qcUyQ2TBfDNLh75hd6+ZusfMsTOsReHsOkJhJEBh48nL
	fPv5BL46s96rWq/YH+TArBwr+7b887+MkKUW7E0XDmlQ3LLLDWb2x++BxebC0XniXZYF1ACNqyB
	+otHVoitEUgXNGY9JYTlZhhwge+XvUhtsJdB3wxwV9STTX0iHqW/S5tp8bgALsJpO1Q8yQn4Ah4
	6Xy/J8lnaVWol56jUdK1goZoh1utmWQMkGXd7OB1s2QubiPIu1RvTde1NvUFlWOMtgAkc/ORsHO
	Z8LU0Fg2vFChqM6FjNl+rsqUzgHqYf7ofgu155pLV0Pg/RzSJpan/d9W+r5Dobh04p+TqJfZuxy
	0foC+P45n5u8nX93FUMmo
X-Received: by 2002:a05:690c:6213:b0:8aa:5af3:e420 with SMTP id
 00721157ae682-8b07ed1e710mr81711707b3.11.1792126562578; Thu, 15 Oct 2026
 21:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791978740.git.zhilinz@nebusec.ai> <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
 <DM5WMW2M6YYO.2X4FN4OPSQGJH@gmail.com>
In-Reply-To: <DM5WMW2M6YYO.2X4FN4OPSQGJH@gmail.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 16 Oct 2026 12:55:50 +0800
X-Gm-Features: AclHuK-R2uMw61ooPFJuj3FAuAmc4ceDB4I1tQc0aEakP9ODeTb-n3CB2dzp8Y4
Message-ID: <CANB6i5wui9AzpQy1MKrEUcd1ifUuE64uZc14GQ9WegtnThxrrQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion
 control access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	martin.lau@kernel.org, kafai.wan@linux.dev, yhs@fb.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 14, 2026 at 07:57 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> > bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
> > and member offset, but does not check pointer modifiers. A BPF program
> > can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
> > write through an allowlisted member, bypassing the read-only cast.
>
> Not anymore. It was fixed in July. See
> commit ac65c710cc64 ("bpf: Reject writes through untrusted BTF pointers")
> and the follow up
> commit ee9ad135b208 ("bpf: Reject a store through a fault prone pointer")=
.
> check_ptr_to_btf_access() rejects such store with
> "only read is supported" before it calls any btf_struct_access callback.
> progs/tcp_ca_untrusted_btf_write.c is the same prog as your PoC.
> All of that is in 7.3-rc1, so net tree has it and this hunk is dead code.
>
> The splat in the cover letter is from 6.12.95.
> 6.18.y and 7.2.y have ac65c710cc64. 6.12.y and 6.6.y don't.
> nf_conn, sched_ext and hid-bpf callbacks in 6.12.y have the same issue,
> so patching tcp_ca alone doesn't help there either.
> Pls send the backport of ac65c710cc64 to stable instead.
>
> pw-bot: cr

Thanks, Alexei. You=E2=80=99re right. The verifier rejects these stores bef=
ore reaching
the TCP congestion-control callback, and the relevant fix is already
in the net tree.
My reproducer was run on 6.12.95, so it does not demonstrate a bug in
the current
net tree. This patch is redundant there.

I=E2=80=99ll withdraw this patch and prepare the stable backport of
ac65c710cc64, as suggested.
Sorry for the noise.
