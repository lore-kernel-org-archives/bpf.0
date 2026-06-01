Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91A357D11
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342642; cv=none; b=EQXWFUZhALtv8tOdCCLEe4X0ISOzYobSD7hzai65PFC2dYzbiXpksLWXOGNiJd1kcrWayVAH2J2n+jYffpwlscV4+mARZRIFQMT0LyRum60nije6uSCdvvdDOmT4bDgzP5JW0I6xqJKUk4zRMFJMy1ug9pcuhYnrvGn8COVd0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342642; c=relaxed/simple;
	bh=50+DEfeJgE3Lxebfeu+NFo2aO5RYfAY/4nITXoPE6vk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qjB3T4ECqHnSxIDTKg232+CbnTkYuvXfvleIXvhNVH+vbioe9SEjZv2HvnHp0lW023Sa4Y24xvWTTbpBVhI3NEB+JhcFlE9P3t0LMmAr+NlD+D4iQ50H8ivjxjrevwieLxGmJ47FcBYhBjNZyy8P11DuUBNBO4nTiATlkA7RoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=DpdylqEG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="DpdylqEG"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137eed84fc6so143203c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780342640; x=1780947440; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQvbwL3Dt4WL4nMWqkkY6hiuIfXBHK13mnGzjOctEdk=;
        b=DpdylqEGA2uM/D1FkIaGy9PX6XQ9YngDPCF48qM1xx1NCtBkbGewDPWxL6qFiuypNE
         GK4H77+qTYvmoiH7cpkzHGxS3+lZJ6kTHvAKIXsgeWwOUG+qxh6rZEs6e9Aqua+RQ7EV
         ruD/KhZgnXVEqp23E2AZ9qFfoEOZTkX+OhVDM03ufJEhcLd+wRFHS23onNvFnZeIFEiC
         yy0kiRo0RgKQY1g2LKNL6JwkwtYAKUPKV5ngjXos1m1jZz/UBhNZZ415uNPspkyp1xKE
         1S/sG6DQ5M3wynOtQdb2Nr5CYPrPjADrkgd3qmQBWVetoU1Ig7BKjcSuGqHso8vjN1ir
         MOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342640; x=1780947440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQvbwL3Dt4WL4nMWqkkY6hiuIfXBHK13mnGzjOctEdk=;
        b=GyFT7y1kI6sXOHkLcxOlZTQbkYM90PaqZSSMlliiDh2XBXCZEDWhvloYFIurP28A/I
         Ssl/+ZSz1DhtSHBDA4rFEZe8QakGF0l9bNEXqAnMPrTO5d5wezVdJ5taJ77rMQUP3I0r
         ri+hKs3JZZQhi3ZJJug1kIT2TmZRpJRtqC7U5LO8Qnxbz88OtaiXa0PMPC9UAjDauNuK
         QllvSVggINZTAT/MxpILsiJMvySBUhar0I3A6upvNDzDIqqnnBfnw8nuDXbmiikakkMM
         S5GG84LPV8howiqPpBHxj5SYGkhwXYQ4QnU9Sxtkzp89qF6YeDSYQpA2Fez26Ad9FCcN
         fk5w==
X-Forwarded-Encrypted: i=1; AFNElJ9IhBC81UuH8TgLjXIcGe/OFXqhCijAVvI7CbdmyA3cLNCzdUy6GdYnsCEt7URsI0LeOAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYOIOJZr0sZOsaPC/Vswno64n8I59HjAddmo/nkEWggetiT8q
	u88tLEXIoSW9AvxOVircaMELAQnxoxEJd84bVaSF10LAIksPffjG6p8nDYfsA0yBDv0=
X-Gm-Gg: Acq92OHsdLvPNNsdHcMNCMzisOSyh03Laf69wWfD58YylBsvKK8XiVZKhb9qjd7Jdls
	UD3VPPCDDpJHR6zKWN27jutSin6ibfc9HF5jYDx3IeW6t9GI7FGL5AfviZjpRGCKjQ4D1d1Nhnt
	DPh/Qwhz5CxdqiljJblQP69tA1r0Stqtih9yVd1NcFeBL1tp8k9o8eytnUCSPvR6t3wp/aUEIjE
	bbPZBiMdul5ACaywkSvS2138i5Vo9ZdlEgL6n7feneT9dngP8XdG73oMpVSqak3m4FF0sElabbf
	kNExPQqf9yCeVI9vn6WD4dEYkhln4uR9Fpek+zo/ecR0Ax+JuvivXBVkP9/LaRy3TwF1NXUWKVP
	7BmhO4YXpAX9xGVsZb7hnyG0+rpPDwkQig3vTJxqzkBrMeqJccV/TZv2iynOYu6v9EVu4c2l+2m
	JjbIRTwRiKcR+C98M=
X-Received: by 2002:a05:7300:2382:b0:304:59cc:aee8 with SMTP id 5a478bee46e88-304fa5a9b32mr5383830eec.18.1780342639421;
        Mon, 01 Jun 2026 12:37:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::ceef])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137dc179940sm5320544c88.5.2026.06.01.12.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:37:14 -0400
Message-Id: <DIXYSJ50VKHJ.1FN2K7SFU8N1Y@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 3/6] selftests/bpf: test cases for loop
 hierarchy computation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> Test cases covering the following branches in bpf_compute_loops():
> - Case B: simple backedge creating a loop (loop_single)
> - Case B: two independent loops (loop_two_independent)
> - Case B + D: nested loops where inner header's loop_header points to
>   outer (loop_nested)
> - Case C: diamond CFG with no loops (fwd_edges_no_loop)
> - Case D: sibling inner loops within one outer loop
>   (loop_nested_siblings)
> - Three levels of loop nesting (loop_three_levels)
> - Loop with if-else body containing forward branches
>   (loop_with_if_else)
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I was debating if it's worth adding the edge case where the instruction is
its own loop header. It is so obviously wrong that the only issue would
be the verifier handling it gracefully, and we can probably skip it.

> ---
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 233 +++++++++++++++=
++++++
>  2 files changed, 235 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 219ff2969868..35d92d176c1f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -57,6 +57,7 @@
>  #include "verifier_live_stack.skel.h"
>  #include "verifier_liveness_exp.skel.h"
>  #include "verifier_load_acquire.skel.h"
> +#include "verifier_loop_hierarchy.skel.h"
>  #include "verifier_loops1.skel.h"
>  #include "verifier_lwt.skel.h"
>  #include "verifier_map_in_map.skel.h"
> @@ -208,6 +209,7 @@ void test_verifier_leak_ptr(void)             { RUN(v=
erifier_leak_ptr); }
>  void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scal=
ars); }
>  void test_verifier_live_stack(void)           { RUN(verifier_live_stack)=
; }
>  void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_ex=
p); }
> +void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierar=
chy); }
>  void test_verifier_loops1(void)               { RUN(verifier_loops1); }
>  void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
>  void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map)=
; }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c =
b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> new file mode 100644
> index 000000000000..84cabfa42485
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/*
> + * kernel/bpf/loops.c:compute_loops() distinguish between
> + * the following cases:
> + * - B: backedge -> simple loop
> + * - C: cross edge to non-loop node -> no-op
> + * - D: edge to node whose header is in DFS path -> nested loop
> + * - E: edge to node whose header is NOT in DFS path -> irreducible
> + *
> + * Below test cases cover the above branches in various combinations.
> + */
> +
> +/* Case B: single bounded loop. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  1       1: {{.*}} (07) r0 +=3D 1")
> +__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
> +__msg("          3: {{.*}} (95) exit")
> +__naked void loop_single(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Case B: two independent loops at the same nesting level. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  2       1: {{.*}} (07) r0 +=3D 1")
> +__msg("  2   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
> +__msg("          3: {{.*}} (b7) r1 =3D 0")
> +__msg("  1       4: {{.*}} (07) r1 +=3D 1")
> +__msg("  1   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
> +__msg("          6: {{.*}} (95) exit")
> +__naked void loop_two_independent(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	if r0 < 10 goto 1b;				\
> +	r1 =3D 0;						\
> +2:	r1 +=3D 1;					\
> +	if r1 < 10 goto 2b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Case B + D: nested loops. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  1       1: {{.*}} (07) r0 +=3D 1")		/* outer loop header */
> +__msg("  1   1   2: {{.*}} (b7) r1 =3D 0")		/* outer loop insn */
> +__msg("  1   1   3: {{.*}} (07) r1 +=3D 1")		/* inner loop header */
> +__msg("  1   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2") /* inner loop in=
sn */
> +__msg("  1   1   5: {{.*}} (a5) if r0 < 0xa goto pc-5") /* outer loop in=
sn */
> +__msg("          6: {{.*}} (95) exit")
> +__naked void loop_nested(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	r1 =3D 0;						\
> +2:	r1 +=3D 1;					\
> +	if r1 < 5 goto 2b;				\
> +	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Case C: forward edges, no loops. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (85) call bpf_get_prandom_u32")
> +__msg("          1: {{.*}} (25) if r0 > 0x0 goto pc+2")
> +__msg("          2: {{.*}} (b7) r0 =3D 2")
> +__msg("          3: {{.*}} (05) goto pc+1")
> +__msg("          4: {{.*}} (b7) r0 =3D 3")
> +__msg("          5: {{.*}} (95) exit")
> +__naked void fwd_edges_no_loop(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	if r0 > 0 goto 1f;				\
> +	r0 =3D 2;						\
> +	goto 2f;					\
> +1:	r0 =3D 3;						\
> +2:	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* Case B + D: two sibling inner loops within one outer loop. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  1       1: {{.*}} (07) r0 +=3D 1")
> +__msg("  1   1   2: {{.*}} (b7) r1 =3D 0")
> +__msg("  1   1   3: {{.*}} (07) r1 +=3D 1")
> +__msg("  1   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
> +__msg("  1   1   5: {{.*}} (b7) r2 =3D 0")
> +__msg("  1   1   6: {{.*}} (07) r2 +=3D 1")
> +__msg("  1   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
> +__msg("  1   1   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
> +__msg("          9: {{.*}} (95) exit")
> +__naked void loop_nested_siblings(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	r1 =3D 0;						\
> +2:	r1 +=3D 1;					\
> +	if r1 < 5 goto 2b;				\
> +	r2 =3D 0;						\
> +3:	r2 +=3D 1;					\
> +	if r2 < 5 goto 3b;				\
> +	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Three levels of nesting. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  1       1: {{.*}} (07) r0 +=3D 1")
> +__msg("  1   1   2: {{.*}} (b7) r1 =3D 0")
> +__msg("  1   1   3: {{.*}} (07) r1 +=3D 1")
> +__msg("  1   3   4: {{.*}} (b7) r2 =3D 0")
> +__msg("  1   3   5: {{.*}} (07) r2 +=3D 1")
> +__msg("  1   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
> +__msg("  1   3   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
> +__msg("  1   1   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
> +__msg("          9: {{.*}} (95) exit")
> +__naked void loop_three_levels(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	r1 =3D 0;						\
> +2:	r1 +=3D 1;					\
> +	r2 =3D 0;						\
> +3:	r2 +=3D 1;					\
> +	if r2 < 3 goto 3b;				\
> +	if r1 < 5 goto 2b;				\
> +	if r0 < 10 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Loop with an if-else body (forward branch inside loop, Case C). */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (b7) r0 =3D 0")
> +__msg("  1       1: {{.*}} (07) r0 +=3D 1")
> +__msg("  1   1   2: {{.*}} (bf) r1 =3D r0")
> +__msg("  1   1   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
> +__msg("  1   1   4: {{.*}} (b7) r1 =3D 1")
> +__msg("  1   1   5: {{.*}} (0f) r0 +=3D r1")
> +__msg("  1   1   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
> +__msg("          7: {{.*}} (95) exit")
> +__naked void loop_with_if_else(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	r1 =3D r0;					\
> +	if r1 > 5 goto 2f;				\
> +	r1 =3D 1;						\
> +2:	r0 +=3D r1;					\
> +	if r0 < 100 goto 1b;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/* Case E: irreducible loop. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("          0: {{.*}} (85) call bpf_get_prandom_u32")
> +__msg("          1: {{.*}} (b7) r1 =3D 0")
> +__msg("          2: {{.*}} (25) if r0 > 0x5 goto pc+2")
> +__msg("  1       3: {{.*}} (b7) r1 =3D 1")
> +__msg("  1   3   4: {{.*}} (05) goto pc+1")
> +__msg("          5: {{.*}} (b7) r1 =3D 2")
> +__msg("  1   3   6: {{.*}} (0f) r0 +=3D r1")
> +__msg("  1   3   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
> +__msg("          8: {{.*}} (95) exit")
> +__naked void loop_irreducible(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r1 =3D 0;						\
> +	if r0 > 5 goto 2f;				\
> +1:	r1 =3D 1;						\
> +	goto 3f;					\
> +2:	r1 =3D 2;						\
> +3:	r0 +=3D r1;					\
> +	if r0 < 16 goto 1b;				\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

