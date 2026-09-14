Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAC2DF134
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429166; cv=none; b=cnTfzGQeJY7JOJ+KlqXn8WqbDs1tgc5b1yCK9ktwj5pijjTH7fzG0zGLv4RrbTlyeP1go9qcv99DTcpUxc+dFDc7vSrKkkLKUsSTuAHaiS46ubr8i5dqZA8n793zK+11JMvIyAVeETl5ngRb9/+dvB1ltGF6gA7ANRe483YjYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429166; c=relaxed/simple;
	bh=AVej2iqlBEYdtl5+BTl9FWTkVtSCQEcHVZ4EMOf/dbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FwLN7FLbu/xfNFJt2ElVfbAZiRqwgEErbdlHPRYMj6zrKEdPX7ZFLZKG+xGs/QmVYFkZ/1mkn2w59F/Xhhh5Qnuk8A3cJR+ayK0ZKTLKxaVPtPeyzP9d2Njp1g/1bYIYg4h9k0U3RRJL5XXVyXWgean+biQq9nRrmdjodCX1H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SmGvOA5c; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SmGvOA5c"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so22455255ad.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789429164; x=1790033964; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RHOj883NdGN/FUoDXIJ1skp4Po4UQoQIExJ8AbqSgLg=;
        b=SmGvOA5ckQ968BxeHvCJetFCQVwFWWLk2ITZFtJcsaWr7MthyqjgQgkfLlGDYZAMg1
         YKHfVkTCmVCHWRhkuMT+1z7snDGlbKYnD54KDBV6hxgl7I1sluSd0WoUEFZJLt1jxeFy
         IAViW3hWjSzV32+Wq1wKpVOfaN9kUcISGkHipxs+mzvnA2SrzTSwpCqcMjtM5lwJFc7U
         nGvgbi1zIDQTd+asTh6PJ8qrG/TP4vRuOi5CMAduBFdsNTWk9qLu845UuI8G5zzyfA6S
         KdfccQ2tUnJhX5OvK36bZk1ZKVsPNGaTXnXeAemKiwA1Hx0Yrl1WFZ3n6fKCfd8NZBlY
         eFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429164; x=1790033964;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHOj883NdGN/FUoDXIJ1skp4Po4UQoQIExJ8AbqSgLg=;
        b=CokqUxPJps/0i0NKAODYeInL8iQKPTIDba93SBVQmf+6UgOty6suRnwWeMPOPk2qI/
         n+15NgotVpEL2bQCgotiDVuEN/8EhxaMctaIba9LaCiXNj+JbIYQRJ4mOGiZu9Iog1g5
         yiMiefa2EJ6qsGb4jKDJhWanKf3d19mtfaBwRXMisSOErWwK+fV+YuXfQ6vkeg7A7jD4
         wiLiAtUbTe2QsJi1zSYAnfiAf1GtRNSDOumV2J5wMKy+Y5KR6RpJLuffY/CtTwSzv/zG
         lg2evoDjfrt2s1wL1+2VS7NWstN9bso1kvVQO0CGaLJgy2e6yNq72s+mavGZ4hCTKh8b
         fRQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6GNMAbFPDaHfGz6iTN98D2t2dtwO7HVQwCPouUWetS55p4CAiCyDCzyBK1tDyNYk0lU4=@vger.kernel.org
X-Gm-Message-State: AFuF++kaKhvWApf/FpWH7tdq61gRag4mUItQr0i4/OZQhfV2OtlTte+0
	LVhYsuv4LKjY1y1HIgC+DarcR9oqoPsqwYVVjHyOTxhmaed2jOEvg5lm1M9A1aUUgrg=
X-Gm-Gg: AYBFou1iWxkWzDsbtDzwQapHk/a1ARByhxbvA5F/GtJ8sClensELTPnejUAgH8n01Ud
	gwQxmBjzRZUMo8mzztwCZFqkuw9uXnUNGoOq+43Tprw1NF40kYKJdM9XqTZ7vbkDocwA+0mMb2j
	g0nbIMpBJa9+Yihq+IEddF1+BUnJOGmzcL2lUYr/Xt6k+MkmFjbo9Wr9cGc+8kbl5IMTkRwCDJ5
	aKp3Fpv+Xe8XlD8LmTU4vYQwi5Znt0koybFDuE+ooMGrL2lXY5kYyiFd6LlMXCGTTNME/yl7wID
	QdDtmYzOShJAzLCes3Ve9xQSoy+nIlAloT/+0tNwNK0G1mt5PriKsxOwfaKJXscmDic2XxgtDo6
	Vyj1mzkZB2Sjy4Voz6obU8FNM3AF1KFTArH2wXg7wxffYTIbhFcStdTj0JyDEVBCkFHG9AC+4CX
	YZx+ljc/hN5gHmxylqlaBq2CjL3e6BI67Bo1o1yFALxGoa4U/XoxS2gajCX5XZCW0ZSJsFh2Tww
	5aPMkzt37o5hqzgt8h+qjbtKUYo
X-Received: by 2002:a17:902:e74c:b0:2db:1f50:6515 with SMTP id d9443c01a7336-2dd6c5ba26cmr88114975ad.2.1789429163979;
        Mon, 14 Sep 2026 16:39:23 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc4403sm56568345ad.52.2026.09.14.16.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 16:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 23:39:22 +0000
Message-Id: <DLFFP4P6CAA6.QLQ38A75G2IZ@etsalapatis.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260911145011.kErTVDkS@linutronix.de>
In-Reply-To: <20260911145011.kErTVDkS@linutronix.de>

On Fri Sep 11, 2026 at 2:50 PM UTC, Sebastian Andrzej Siewior wrote:
> Networking used to print the socket pointer with %p as output in the
> /proc interface. This was later changed to %pK in order not to reveal
> the actual pointer value. The output format has then been copied to bpf
> tests which produce the same format including the %pK format modifier.
>
> Networking recently replaced the socket output with a plain 0 because
> the socket pointer added no value to the output and the %pK should be
> removed fom library handling. The format remained otherwise unchanged in
> order not to break any tools which are parsing this information.
>
> This change removes the %pK modifier from bpf, following the change in
> networking.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The bots are being overly picky bere, the tests pass fine and these are
selftests anyway.

> ---
>
> The networking change is in net-next as commit 7c0ec6288b497 ("net:
> Replace %pK output with 0")
>
>  tools/testing/selftests/bpf/README.rst               |  2 +-
>  tools/testing/selftests/bpf/prog_tests/snprintf.c    |  2 +-
>  tools/testing/selftests/bpf/progs/bpf_iter_netlink.c |  4 ++--
>  tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c    | 11 +++++------
>  tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c    | 11 +++++------
>  tools/testing/selftests/bpf/progs/bpf_iter_udp4.c    |  4 ++--
>  tools/testing/selftests/bpf/progs/bpf_iter_udp6.c    |  4 ++--
>  tools/testing/selftests/bpf/progs/bpf_iter_unix.c    |  3 +--
>  tools/testing/selftests/bpf/progs/test_snprintf.c    |  4 ++--
>  9 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
> index 07c834433b388..75ff1142c1857 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -187,7 +187,7 @@ The symptom for ``bpf_iter/netlink`` looks like
>    ...
>    15: (bf) r2 =3D r7
>    16: (0f) r2 +=3D r1
> -  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
> +  ; BPF_SEQ_PRINTF(seq, "%p %-3d ", s, s->sk_protocol);
>    17: (7b) *(u64 *)(r7 +0) =3D r2
>    only read is supported
> =20
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/te=
sting/selftests/bpf/prog_tests/snprintf.c
> index 4e4a82d54f799..f2cd442c4683c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -16,7 +16,7 @@
>  #define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> =20
>  /* The third specifier, %p, is a hashed pointer which changes on every r=
eboot */
> -#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> +#define EXP_ADDR_OUT "ffff00000add4e55 "
>  #define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> =20
>  #define EXP_STR_OUT  "str1         a  b c      d e longstr"
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_netlink.c
> index 00b2ceae81fb0..b9107d3ab6039 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> @@ -25,12 +25,12 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>  		return 0;
> =20
>  	if (ctx->meta->seq_num =3D=3D 0)
> -		BPF_SEQ_PRINTF(seq, "sk               Eth Pid        Groups   "
> +		BPF_SEQ_PRINTF(seq, "sk Eth Pid        Groups   "
>  				    "Rmem     Wmem     Dump  Locks    Drops    "
>  				    "Inode\n");
> =20
>  	s =3D &nlk->sk;
> -	BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
> +	BPF_SEQ_PRINTF(seq, "0  %-3d ", s->sk_protocol);
> =20
>  	if (!nlk->groups)  {
>  		group =3D 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_tcp4.c
> index b1e509b231cd9..d149cf0d07be6 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
> @@ -131,8 +131,7 @@ static int dump_tcp_sock(struct seq_file *seq, struct=
 tcp_sock *tp,
>  		       icsk->icsk_probes_out,
>  		       sock_i_ino(sp),
>  		       sp->sk_refcnt.refs.counter);
> -	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
> -		       tp,
> +	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
>  		       jiffies_to_clock_t(icsk->icsk_rto),
>  		       jiffies_to_clock_t(icsk->icsk_ack.ato),
>  		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
> @@ -161,10 +160,10 @@ static int dump_tw_sock(struct seq_file *seq, struc=
t tcp_timewait_sock *ttw,
>  	BPF_SEQ_PRINTF(seq, "%4d: %08X:%04X %08X:%04X ",
>  		       seq_num, src, srcp, dest, destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n=
",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
>  		       tw->tw_substate, 0, 0,
>  		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
> -		       tw->tw_refcnt.refs.counter, tw);
> +		       tw->tw_refcnt.refs.counter);
> =20
>  	return 0;
>  }
> @@ -185,9 +184,9 @@ static int dump_req_sock(struct seq_file *seq, struct=
 tcp_request_sock *treq,
>  		       seq_num, irsk->ir_loc_addr,
>  		       irsk->ir_num, irsk->ir_rmt_addr,
>  		       bpf_ntohs(irsk->ir_rmt_port));
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n=
",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
>  		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
> -		       req->num_timeout, uid, 0, 0, 0, req);
> +		       req->num_timeout, uid, 0, 0, 0);
> =20
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_tcp6.c
> index dbc7166aee91f..cd65fa81f1219 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
> @@ -135,8 +135,7 @@ static int dump_tcp6_sock(struct seq_file *seq, struc=
t tcp6_sock *tp,
>  		       icsk->icsk_probes_out,
>  		       sock_i_ino(sp),
>  		       sp->sk_refcnt.refs.counter);
> -	BPF_SEQ_PRINTF(seq, "%pK %lu %lu %u %u %d\n",
> -		       tp,
> +	BPF_SEQ_PRINTF(seq, "0 %lu %lu %u %u %d\n",
>  		       jiffies_to_clock_t(icsk->icsk_rto),
>  		       jiffies_to_clock_t(icsk->icsk_ack.ato),
>  		       (icsk->icsk_ack.quick << 1) | inet_csk_in_pingpong_mode(icsk),
> @@ -170,10 +169,10 @@ static int dump_tw_sock(struct seq_file *seq, struc=
t tcp_timewait_sock *ttw,
>  		       dest->s6_addr32[0], dest->s6_addr32[1],
>  		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n=
",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
>  		       tw->tw_substate, 0, 0,
>  		       3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
> -		       tw->tw_refcnt.refs.counter, tw);
> +		       tw->tw_refcnt.refs.counter);
> =20
>  	return 0;
>  }
> @@ -201,9 +200,9 @@ static int dump_req_sock(struct seq_file *seq, struct=
 tcp_request_sock *treq,
>  		       dest->s6_addr32[0], dest->s6_addr32[1],
>  		       dest->s6_addr32[2], dest->s6_addr32[3],
>  		       bpf_ntohs(irsk->ir_rmt_port));
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n=
",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d 0\n",
>  		       TCP_SYN_RECV, 0, 0, 1, jiffies_to_clock_t(ttd),
> -		       req->num_timeout, uid, 0, 0, 0, req);
> +		       req->num_timeout, uid, 0, 0, 0);
> =20
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp4.c
> index 23b2aa2604de2..9b789f09f1462 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> @@ -57,13 +57,13 @@ int dump_udp4(struct bpf_iter__udp *ctx)
>  	BPF_SEQ_PRINTF(seq, "%5d: %08X:%04X %08X:%04X ",
>  		       ctx->bucket, src, srcp, dest, destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK =
%u\n",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d =
%u\n",
>  		       inet->sk.sk_state,
>  		       inet->sk.sk_wmem_alloc.refs.counter - 1,
>  		       rqueue,
>  		       0, 0L, 0, ctx->uid, 0,
>  		       sock_i_ino(&inet->sk),
> -		       inet->sk.sk_refcnt.refs.counter, udp_sk,
> +		       inet->sk.sk_refcnt.refs.counter, 0,
>  		       udp_sk->drop_counters.drops0.counter +
>  		       udp_sk->drop_counters.drops1.counter);
> =20
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp6.c
> index c48b05aa2a4b2..9766eff7069ff 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> @@ -65,13 +65,13 @@ int dump_udp6(struct bpf_iter__udp *ctx)
>  		       dest->s6_addr32[0], dest->s6_addr32[1],
>  		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK =
%u\n",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d =
%u\n",
>  		       inet->sk.sk_state,
>  		       inet->sk.sk_wmem_alloc.refs.counter - 1,
>  		       rqueue,
>  		       0, 0L, 0, ctx->uid, 0,
>  		       sock_i_ino(&inet->sk),
> -		       inet->sk.sk_refcnt.refs.counter, udp_sk,
> +		       inet->sk.sk_refcnt.refs.counter, 0,
>  		       udp_sk->drop_counters.drops0.counter +
>  		       udp_sk->drop_counters.drops1.counter);
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_unix.c
> index a2652c8c3616f..36690478992f8 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> @@ -44,8 +44,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
>  	if (seq_num =3D=3D 0)
>  		BPF_SEQ_PRINTF(seq, "Num               RefCount Protocol Flags    Type=
 St    Inode Path\n");
> =20
> -	BPF_SEQ_PRINTF(seq, "%pK: %08X %08X %08X %04X %02X %8lu",
> -		       unix_sk,
> +	BPF_SEQ_PRINTF(seq, "%08u: %08X %08X %08X %04X %02X %8lu", 0,
>  		       sk->sk_refcnt.refs.counter,
>  		       0,
>  		       sk->sk_state =3D=3D TCP_LISTEN ? __SO_ACCEPTCON : 0,
> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/te=
sting/selftests/bpf/progs/test_snprintf.c
> index 8fda075440235..48a0025cf2ca8 100644
> --- a/tools/testing/selftests/bpf/progs/test_snprintf.c
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
> @@ -57,8 +57,8 @@ int handler(const void *ctx)
>  	sym_ret  =3D BPF_SNPRINTF(sym_out,  sizeof(sym_out), "%ps %pS %pB",
>  				&schedule, &schedule, &schedule);
>  	/* Kernel pointers */
> -	addr_ret =3D BPF_SNPRINTF(addr_out, sizeof(addr_out), "%pK %px %p",
> -				0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
> +	addr_ret =3D BPF_SNPRINTF(addr_out, sizeof(addr_out), "%px %p",
> +				0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
>  	/* Strings and single-byte character embedding */
>  	str_ret  =3D BPF_SNPRINTF(str_out, sizeof(str_out), "%s % 9c %+2c %-3c =
%04c %0c %+05s",
>  				str1, 'a', 'b', 'c', 'd', 'e', longstr);

