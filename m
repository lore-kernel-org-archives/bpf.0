Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8263E0C4D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538255; cv=pass; b=f5VsqYvh+sjMG9E00nJ7qgPoRpIGEkkhW8AFQOTE1kUFgvbMzlJlt4TCjYdboSN5v3JPlYBwc+qAhgUihyX1e3TtPHixw0I5UZHT66DuiLbZu0glxlvJei/HFhEF0g05mBcyJbL2gFpGg7857P1yGK2BrbJ14pXzf6YksbQqYeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538255; c=relaxed/simple;
	bh=VliYoNm9L/I+WmONyNulPZNlcTjT8AH8gN8t50yoaHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N29Fgl1If8XEfBQ9EXpaxDpahQGMQlcEcmzAfklQFyt5ctVPRrxFRvvxi2pnsgR/+9kbFxCLLMluIbpbNG6joFI+miAw57hMzHqs+S+3mBpixxxMutUpNhcY06lb51nIm4uQFP4RctH8elf5/y8OHKsk+sYLG12UMAPFI9P688s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az0+OWr6; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az0+OWr6"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4c0766cbe64so328752b6e.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789538251; cv=none;
        d=google.com; s=arc-20260327;
        b=IWUE7xfWRYYVCZDHnpTHul5QblyGl1sEeYR9Vqp0OJXGo2wenCx435rnASd0cqQ0pj
         Chf5C5RhE8C+0KSTasTgb27nmQzT3C+gdJwdcVLJwViRxbT0UNoCnJLqTMdKSdnRrerq
         iXdLL6ASw5ECoDBtWGZW2cV1LCO1p6WETxjl23z2FlVu2J6p/XZk2BlgRCiD3p85lPo4
         uBBr9EaoGH80Jh+z6VO6uWETkwi9F3yl0cu2A7Sl201ilZN528OV5xJ+ddMvkgzHZJe9
         1qpNvkK+mV7g2di9E/ZQR4bJ2DsnLRTE1ttaq9EnahFw/QCBFdNQNIutjllHhwATWd/n
         jX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        fh=gTMnKQOEjPifQ76zkpnUAsa464a59Rp5jluFZ9Fx5Gg=;
        b=nCTaBQlGqnp7jwxWJ5C/mWYlJDJWKIX9pahnhafob2lXFMJbi8kF2Ijj0siQbeXlgG
         fyED5xWE1LAMMvSv1KB+LDTxG1uCCJ7IwMHol4D501ZGfcTbZTk6PFAeJV5HX0Plt1CR
         OKBu0XDRVNk9K2C3Ep6z0p4xUT+Q4lTRO1+IvmLkHfqKhIsUMQoL1HG5eSbZ1WtxgZaJ
         1s/gFfbZCW+0cnKBtwJRoK28U1CPt9Hbl+q0CoiwzS9FFbpiIyrZmGE0ijz+t0vhkrEF
         wEQX619HZl7vJzb2ReUqX2iWLBAA5jmy73j0qv5kQpn9MtG42SyPf2gVnCk6m8t7DHsK
         9TBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538251; x=1790143051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        b=Az0+OWr60rLJHtTlKMmI9DRZbdc62TOiS5c0GwojfzuXmFa83X6fZb0cwswO7rmC8m
         REVgwEJnZq4/NICAtFsS2+fDJ0e2Ej8aFgW0AMGvTDEkU/QGOk1WOqFgsaOrfLbQCABU
         4iML7gU/BiY9WP1fXzrPo7/Idadxfqggz3YBQ7+XIJ4zlIuDeKZL69i3rKmYxmlMlePv
         Ereuxpr4j5JowoR+D3nJHudHSgkEJ7Lv78+H0bP0U5f4V/rk26tnO1ab0P0A7bY/4rIK
         N/bN9oDOSlUlPYO+lyuazpXovbf6utVWhUAowGvmm20wC9f9OGmFB8SVEut/pNTah7aE
         37Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538251; x=1790143051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3+4CHA7p/PtNxnOjFIKd8kLmKZDJTVsu5fi3JRfwyw=;
        b=hFg0O6hHzo8TkwXQqrAXt8Pct3SVJEb/0C0OnRBdh2cEl7Kbaz62CfBOfDvlal8hOo
         4TmoLWv5SVcj3RSXL1iTDnJ2TpV8XXD8NdmzwFI3c7VTAVR74rM55Cg+Dk83pr/VCGWw
         npuvc9gRDuElPFc+9s/FMWmpeVHjZXvsX1/nP2gMG2U2QRYDkAgRsQ8Q80M3HEa6R2+5
         Sxp7jmHDCVrTGBeUvRChIQOL2ago5rPq/w4vhqsiN35ey1qH7G+M2jmige9lcRIpDEnk
         hD9ngMeLoB+itllZ+PqQyzPFwf80Qk6rZhssCsn318ryFAUg8pu+WfMn6bWdZ/TvBTdJ
         97kQ==
X-Gm-Message-State: AFuF++n8jSmKHHrbmc1Up6TdFcro5ml2UL1JAgJU0SIJgBvmnuuTua9N
	axcpW3vnvaSBzgLJIU4l94Ix/Pa+skQ/efb8YjqD3A2suMy7joI16ovuSw35784to/EyasYITf1
	AiKOEchR+xq9AGFqs8POMSUTbkb2l59dg5LO2
X-Gm-Gg: AYBFou1Tl7oLaGbT8D+q6A9BsonLdvba/rsGwrHd/+sb1gh+Gu6a5IGuStY2fBhd1jD
	YNsjLSPO69olqCCp5KAp46aFySIqUD+2RcYml4+v9WJNZyHqXDTKXtKd161sYKvWWn81G2dK2PX
	c8rFeY6cyBaAqWAqkJcsSE+mlB+SiSeZc6ag6uXfBI1cnK/PSu4hiJGOzluU5lgGKNtKzzerw3b
	5I6OJP5vt6s1ZCa/UTRvdPjOTvAjYiUzzGjbuONqB+adL4XSGvH2T/JsU6Q5xGbMrUUZDamFQ7F
	Lqk+935R2OFmYxzPv+ybCG/kbZ7qmQf8pNWrEiqOMxmgxZNawmHzX4rN5WvqZHJHdg==
X-Received: by 2002:a05:6808:6d97:b0:4c1:760:e5d6 with SMTP id
 5614622812f47-4ca4a3fbdf8mr3171564b6e.5.1789538250754; Tue, 15 Sep 2026
 22:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916050830.8774-1-emil@etsalapatis.com> <20260916050830.8774-6-emil@etsalapatis.com>
In-Reply-To: <20260916050830.8774-6-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 22:57:18 -0700
X-Gm-Features: AcwNN1Vq5pvkGB5jsdSy_GgFG1r64gTDSSL0mN1c2qYcfh2-PyhJyxDpFIyNp_4
Message-ID: <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The verifier tracks changes in how PTR_TO_PACKET registers'
> bounds are modified across subprog boundaries. PTR_TO_PACKET
> registers are actually passed as PTR_TO_MEM, which is assumed
> valid for the entire call. This is not the case with packet memory,
> where a pskb_* call may invalidate its memory region.
>
> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
> because we would also need to somehow pass the PTR_TO_PACKET_META
> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> subprog is guaranteed not to mutate the packet.

CC Mahe.

Hi Emil,

There is a related but separate issue [1] addressed by 8fe994c80af2
(=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D). I=
 think a
long-term solution could be supporting ARG_PTR_TO_PACKET for global
subprograms. For example:

int parse_something(struct __sk_buff *skb, __u16 off,
                    char *data_start __arg_packet, ...);

The verifier could require a real PTR_TO_PACKET at the call site and
verify the global subprogram with a real PTR_TO_PACKET, rather than
converting it to PTR_TO_MEM. This would preserve packet access rules,
allow reads from cgroup_skb programs while rejecting writes in the
callee, and automatically invalidate the argument after calls such as
bpf_skb_pull_data().

[1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t

>
> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d852..507bc14b4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>                         if (check_mem_reg(env, reg, argno, arg->mem_size,=
 BPF_READ | BPF_WRITE, NULL,
>                                           NULL))
>                                 return -EINVAL;
> +                       /*
> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, preven=
ting
> +                        * us from adjusting bounds tracking info.
> +                        */
> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr=
_slice_pkt(reg)) &&
> +                           sub->changes_pkt_data) {
> +                               bpf_log(log, "%s is a packet pointer, but=
 func#%d may change packet data\n",
> +                                               reg_arg_name(env, argno),=
 subprog);
> +                               return -EINVAL;
> +                       }
>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
>                             (type_may_be_null(reg->type) || bpf_register_=
is_null(reg))) {
>                                 bpf_log(log, "%s is expected to be non-NU=
LL\n",
> --
> 2.54.0
>
>
