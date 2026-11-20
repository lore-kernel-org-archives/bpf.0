Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795212905;
	b=eSo7WhqUTYciQ1CZUGkheZ6X6rw5DQqJJ3fFL4/zWO7DCn7q2PtFzlX0S3ZHjvGKwIL8
	 97eU+JltPw/IZqpDLAzgx++2PHh95LK4kii8JuroJu1f0P+lq8GInO6V2jg53EeDyMiuZ
	 ntG0fUX6G8A4A6zqOUZDXxv063q22pxavJPjRd4iypdPqGCwc3SV3YBokiB1qO+iR3FTy
	 Jo1hQv5VrIfZvR6gYJnty81PqUz07tqygStOx1vBg/4AojEY2YDuJLnLMIFRWXXVuNI3c
	 ubuA2AvuoZNKKFlwa4mTAdrmuGFplIYDnfzjhgg1PzvKRrAk7le9aS5G8EU7U0+F1Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
	b=Bb1VACHNdgIZ0DaQyh8o8RbvAR98jXfjWP1DXgPYfIGbIUo3C4qbUXxE0Zd6dGd2z6ng
	 898A6zF61UO0FKfK41qGaYxxdsICg8xpM3+l1MU2AH9l5JvjGZNlVxw9RLazEu5kcP4Q2
	 u9Wz/4pIUIwr23iBJElgBuVXBz9Gci9MmPTozVd6XXwgU9KkWmhsOfdUg2D6mQ+RWshF3
	 vWYVKzvIlIFc3YZfDtZYcEOwr/EgX2e8s8PmDJNxdBwOiE73fTvQ00mcBEEGOv20t3r1V
	 cQcTZIDBHuAAp876mL4uxGwvw+y67c/MuVxvH6yDZ2mgYbuH2/nOBnOqhfzZPb01MoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3SOdlg4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2E606A684
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B2E606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3SOdlg4
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70059e4dab6so851052eaf.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 14:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795212902; cv=none;
        d=google.com; s=arc-20260327;
        b=aY9b4TLzeSLDw9xCTChlBB9jyIxyX1b00JyiDwu8bmY4aUhWz2hvD13gpBZT+76ntp
         Y+3FvLPKa2633C7wg0gS+Hq3iBF25Z/IqJSQoTCJ9uAGM+qwJRqf8I5ali1yCqv4/2LY
         moNJy+MgnSyE7Zt/FuCl5HO/TIHYNvbXtH0UCHgPc/EBZqgQxiNS5q/BEjtaCUYEt7iD
         ZbjmwdDlcTc+9HgGaEy8a/YAVcTD29Rfn//fG87q5AFT9w5DEUZAcB+IpG6c8bjVxlym
         1GqaBVo+lnFCNBnwwUvdt5VGscyHL38VNXsky4bLUnqzGajeXWAxOeD7a9QA5NaY5Vmz
         yD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        fh=WDiiQ46mZwYAqsQ2MjdjA8mSjBRhruE2ZeAXp8x+oRs=;
        b=onBUMXjuxaJzQpaV5m3t4vz1WUoMhKYWWXDfipO6mBmGXPuGQ7y8RIRc5X81xNeK6Z
         hnhbnSrSXPrGPLPTj036F+EvW6p4JpOmId8uEWP6EV00UTDLHQCIzRCqeJ9oRlFdlcU0
         mrvUemEzh4TedlE5h6RO5MFh0A7SygsIGDl9UDqALhMZg0ZOpomLdGDweiEoD7nbkBvv
         dlhS4bl2XDHqCBv6hRa9jGP0/T+8av1IGnt7Fo0eLjT8qsW4iYsQKxS1Iiww6WWhUBpY
         Le6p0K6JBQaEI88+rqACOg7f0bz/U4S2KlmKpK8hfx/GBPAimH3YU07sxSwB12q5AHzo
         CuHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212902; x=1795817702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        b=l3SOdlg42qbKIlI9+Ac4MBHXRldrvquCDkj/z4faFkQvuVq4q6ueXT7hGjf1x2DZ6J
         xr0kGpYWy6XzLMIYfaRXYEt32hzwIUIh5GcDjS5qMo+NTm/W2h4QLrWT0vjrrNJqAY/V
         DaHg/hTmuXLf/SbZgeXG7LYeRhLX6xEIsHTO6045XjdtPDKJm9dClJoHuo7IikmLqZyI
         LHip8V4qxMZCOM5nMYFwgXFSqKhOQGq15asHuhcCUR+1HQYSdRVD1FRKEvvrmiwEApWn
         r/Lj6QL4JWoSFYjlCjmkEgRPT9oWf0bS7UiyNNPJvMB1PL+uXio1JWvcqawJCFSR4NEc
         ME/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212902; x=1795817702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8E5/bKsqcml1NiDKuxtkXF2hepTan04xWFr5FhLnOc=;
        b=Mch4pg09jxK290p/jDav31wPNdbLkHjWN4sE73gfphmd4l0wy/8Y3x/t8uXEvUZ4XE
         V/3/Q4tzxi+2x5umtqPatM+WT3AiD80d3lQbRJqrAb8ZU8AEcezRqIEoHJ10oRpmqb00
         5aW1GN0C2gb72WTNF5EpodSc1xQRNsGlhMk9NeUnv+qZIwKrJshJ49KtvIYt50L8qBzU
         XBLXPFai1YnmsQ8ZqE9CdtpHyftRYPOTiRGyhBYST0lO8Xqa1qtgvAEFzTsR6p8I9Ii2
         tlEFKpWdexHRdI0q1c+XHzvE2wScQe1pmMPLLyRFvbkyanpwmbleatXYQkbNmutO56MW
         T1MQ==
X-Forwarded-Encrypted: i=1; AL+hErEi3hhmLnX0Zmydfk2scUsee0vR09ZNARiEyz9CEau5HSPmzVG/DX2yFOy7UIucvNBWjzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j/a4sF55MmRHsmLobiJYGesFJjvChP4cp6ZyBg4JjJoPRGysr
	DJf5wVMkJhcjOKPWvgfcKwgrPNRO9FLO70FoCypYUib3TINFTEHCqVTFTewlzu96PesNPDxIrFb
	jzYtGYdcy7YrkYQYxspJGLgNfya3zTSg=
X-Gm-Gg: AYBFou0UvxqoiWGxtg5luDRRFvMjaj2oodDHLqzIyfohdyoMKHZnYQ7zrhwaU/D1yOI
	jEL301uORYHwKU1rJYT3GIutPHXnjj51QNIBwo8pWYOW8bqZ1xr0eHt56r7xk+O53kLmyPuNUiW
	SQDnCC9HrnIEWu9UQjdRIwWp6mHWGvS//B0y4+fY0itduzQq66yeMvnhVCeoX9WR8Y9UakE3n+m
	lZ/az7k/Sb9Nt981wrPF8yCzkQ9dJ8BtSp+7TJkjroFZMhPJPGB2Mkjumy16PbLLz/fUMPXxQia
	VWoaLigPvjdy4+MCBmFT3At06FSATI5gXeqrMRwtn6HfKniyPr29sqyl/NYItpj2RHEqSPti3Qv
	Fd+p8Qd4Oi1v4HOVVXw/1pPxPoi+ueCDisW0p
X-Received: by 2002:a05:6820:4615:b0:6f8:8385:52a with SMTP id
 006d021491bc7-71b395ac078mr3579653eaf.58.1795212902477; Fri, 20 Nov 2026
 14:15:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
In-Reply-To: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 20 Nov 2026 14:14:24 -0800
X-Gm-Features: Aa3M54rA3AVclKtpTsDBdZrwTvIcM9OP1ypUCaxAnAe_aZyVGm-fhga0xkyXQgY
Message-ID: <CAHsH6Gt7RkR1kKXQaQUdz-_8VYXfW7NcwPxNtzwaHtBYWgRuqA@mail.gmail.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm interface
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, ipsec@lists.linux.dev, 
	bpf@vger.kernel.org, stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 20, 2026 at 6:09=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Found while auditing the xfrm metadata consumers of a steered packet. One
> of them is an xfrm interface, which restores the original route before th=
e
> xfrm lookup; the swap warned on the metadata dst still installed in the
> skb, and only the collect_md arm restored the route at all.
>
> The issue:
> An xfrm interface takes the if_id and the underlying device either from i=
ts
> configuration or, in collect_md mode, from the xfrm metadata on the skb.
> When that metadata also carries the route the packet arrived through,
> xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup tak=
es
> the address family from it. skb_dst_set() expects the dst slot to be empt=
y
> for a reference counted dst and warns when it is not, so the route landed
> over a metadata dst that was still there; a kernel built with
> CONFIG_DEBUG_NET=3Dy panics on the first packet that takes this path when
> panic_on_warn is set.
>
> Two more defects sit in the same place. An interface with a configured
> if_id never restores the route: it takes the metadata dst as it is, whose
> address family is AF_UNSPEC, so the lookup finds no policy and the packet
> is dropped as a link failure instead of being transformed. And the restor=
e
> moved the route out of the metadata dst, which a clone of the skb shares,
> so the clone that reached the interface first left the original packet wi=
th
> nothing to restore.
>
> The same slot overwrite is in the unstable helper a tc-bpf program uses t=
o
> attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_or=
ig
> and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
> every invocation of the program, so the restore cannot keep anything in i=
t.
>
> The Fix:
> Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> dst_clone() so the metadata dst keeps its own, and empty the counted slot
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.
>
> Conditions to recreate the bug:
> A tc-bpf program that records the route as dst_orig with
> bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper=
,
> so the first packet that calls it panics inside bpf_skb_set_xfrm_info() o=
n
> a CONFIG_DEBUG_NET=3Dy build with panic_on_warn=3D1.
>
> An interface with a configured if_id shows its own defect without any
> other patch: it drops the packet as a link failure without consulting the
> outbound policy. And a clone made after the metadata was attached consume=
s
> the route before the original packet arrives.

Thank you for the fix!

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
