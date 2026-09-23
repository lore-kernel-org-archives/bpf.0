Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56901568558
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195337; cv=none; b=tlypFhFqyucGnt+lcvSuQKpZNKcySXEjdS8xr2VEC74bTyHF2w/bhVLBNTlK7MKVM/3jvddhUSTQ1vApjguvD6hixFpNl7LaKZt+73d0fUWPjcKUKMvwXEYMe9oq7dqTLly8OFAMqe48XjjuLG2B3z+OmmyoFVzmDDZRs5FXr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195337; c=relaxed/simple;
	bh=GAQWOHjax/xBe/38xhc5ZgnfQhH5Z5AieWex4zol8bY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rAPAtRIa5H+bJP29kr5MZfn9LNSEQ+Esx1NK+Wq/Qy06d9L2UEsa6kUkUTrvs/tZrE42ublCYnb7s004dGNeqNqZgByjQBEF8qSUjIhIk54MvD6CvQdZN+ZxHtoR+Y5/nqrvzC6FHegqKOqd1X8MeC1G/bYYEPkDh8ffYsU3NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHoH5Psu; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHoH5Psu"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so407522f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195325; x=1790800125; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q2RYEIrUx6VHqfYNqHQp3bHjXaY6b5+kASqkmHdYb0U=;
        b=PHoH5PsuLnVDDxOAvPXGCsLPkqaEQu+H1J1A2f/+OejyoGF+kdy9lE6vVD/ubH4b3c
         lLZidfSxW7OioNwPFh2YFf+fLqN8ALvB7IxOjDoa82t45+PKHEsB0OLGCLK9Pdh05P00
         y/DgqCi8huWeGXgTnnEKKdscKwAgecWZEn2Ksx7rifgiFAC1haSFuMuuiUEh9VU9ZYdo
         Lu1WRpFtbMmKUz4CtEmzbiaS1mFw3ExTA0iaDKY2tJbeQXsx4MSxNtKRAJ80jZ7IFf50
         pOPg9DMfdyQK+ywujFyVEAFnL5n6l3YQO+zrmCvYv1DYY1k2g9iRbQIr/uvuya6vVCTi
         V05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195325; x=1790800125;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2RYEIrUx6VHqfYNqHQp3bHjXaY6b5+kASqkmHdYb0U=;
        b=Hp4F4AccyBukEDpbJ90HMAoFcGmThWf+sCz+DDgdCIVB1FzEKGdC+Hge8QfzT9dB9f
         xFaCmKmMRBwD6WPVrjZtSpj0wK42ABhEopzstYtH2O5rOj0/cLIozzxER9SQbk6OK8d7
         I4JYTwijOJ0bXXJSWmmsvRP8dtpP5MqW8TXMjF9CFsEYDnDqtmsx2NjFnWZme5a2anhM
         31JwjOXbSypCk/y1nA+RqKPiyNjmzf6av+wjLNzF//PguO6XZH04h4rw2ZC/ZzBzCjDQ
         m959QNA2ZjW97YEu7jGv91V1NT1wVWJR9RxJVyG5HQG2fq5RCinEKXhXUfr266DthXAX
         D+Bg==
X-Forwarded-Encrypted: i=1; AKwUvBycIJ/W1FrvpPsBdvod2Eqmt8iNY7ryo4qtOdSxcUE26hxi1ZGti5F0z7u4BsPzfCt/zgA=@vger.kernel.org
X-Gm-Message-State: AFuF++k06WYo3k4yhzY/YRjMHoiegkkM3hEN187Nhkt9C8F43KIgMq24
	TCwUAAXcd+tLJDqTCdU7NoKTFN4teWhHIhaxgPKuIkTr/sihhWxjptuz
X-Gm-Gg: AYBFou1Rpg06fT5BM5FZBiVjsUXF6kWHwEKT3sOEaAU/2ibPjZjNT+fdPk0tZNc4B3n
	EFsnPnikaR+9zUkbjK0E5422ItfpkIYagfOgPwdJ7WeF25JmgtMI3fFSXgbScMJ8zziuFkoULgJ
	rPP/Ukw93prhwa3DGSknjICAPFjdAaNyT8aCtEIQeFxkZNpojh4WZ6gdk8zTcRQ4TMU+vfhJBVj
	o7i8RkIb43+Sbcd/wfinkLmWNxyV9Tvo2VtwCe6xq5Vi4fm4+0BQmCp+Ntvrb/RlquR0vCf6tiE
	HorWRyt0kVZE7UXHDOJelzsjHHnLdl6a6aptujYBS6NcpgSN3erzT0x8OOSHcMABHL3fJPLCmgk
	1RkK4vGXkLGE6RFkZLuynuBvezpSsEJThICwA1feIuUwkc6JGT5C6aA4hDvxfJg/9pW+KuETd+I
	4wOVkgafj/kVQv8FxOMlf3nAYe8IuRYAPVNTwOgz3zIataiZYt3yHYPr8VWtxNZB6Fdg070nI4k
	qSgdu+bxTlcC362g8m620dWtn9fCw+44ZlMR3wWID4GcypyPPnBXy1VSC6JrUXizzwDzPr+9msM
	bzQWSFGz3dCwguPqJzkbGw+yDT+N8Qn52MkxN3lsM43FjN5x
X-Received: by 2002:a5d:5846:0:b0:487:f31:ee31 with SMTP id ffacd0b85a97d-4887197f2e2mr406078f8f.56.1790195324641;
        Wed, 23 Sep 2026 13:28:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868779472sm9676432f8f.23.2026.09.23.13.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 13:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:28:43 +0200
Message-Id: <DLMZA2A3V3BE.2EHXDWY1TNHRY@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 18/18] selftests/bpf: Test the 2 KiB stack
 budget
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-19-memxor@gmail.com>
 <0c79a8882d6a3efb42ca407727b2a03ac66675272e0610b319996f582c22cd31@mail.kernel.org>
In-Reply-To: <0c79a8882d6a3efb42ca407727b2a03ac66675272e0610b319996f582c22cd31@mail.kernel.org>

On Wed Sep 23, 2026 at 10:12 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_s=
tack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>> index 98db9bafa44b..2b3ec2b79091 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>
> [ ... ]
>
>> @@ -78,6 +79,34 @@ static void test_private_stack_recur(void)
>>  	struct_ops_private_stack_recur__destroy(skel);
>>  }
>>
>> +/* Two frames of 2 KiB each on the private stack */
>> +static void test_private_stack_large(void)
>> +{
>> +	struct struct_ops_private_stack_large *skel;
>> +	struct bpf_link *link;
>> +
>> +	if (!is_large_stack_supported()) {
>> +		test__skip();
>> +		return;
>> +	}
>
> A subsystem pattern flags this as potentially concerning: The BPF
> selftests guide recommends always including a reason string in the skip
> message so future debuggers know why the test was skipped. When the probe
> gets a clean "invalid write to stack" rejection, is_large_stack_supported=
()
> prints nothing, and the subtest shows only SKIP with no indication that
> the reason is missing large stack support.
>
> The test_loader's run_subtest() prints a reason
> (printf("%s:SKIP: %s\n", __func__, spec->skip_reason)) before calling
> test__skip(), but here the skip is silent. On the other hand, a bare
> test__skip() with no printf is the most common idiom in prog_tests
> (about 90 of 149 call sites follow this pattern, and the #else branch
> of this same file does the same). Could this include a skip reason,
> or is silent skipping acceptable BPF selftest convention?
>

Won't fix.

> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/=
testing/selftests/bpf/prog_tests/tailcalls.c
>> index c5c9d6c359bb..c5e3f198ca7f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>
> [ ... ]
>
>> @@ -1953,6 +1954,45 @@ static void test_tailcall_bpf2bpf_fexit_links(voi=
d)
>>  	tailcall_bpf2bpf2__destroy(skel_tc);
>>  }
>>
>> +/*
>> + * test_tailcall_large_stack runs a tail call made from a subprog with =
a 1536
>> + * byte frame, under a 240-byte caller, into a program with a 2 KiB fra=
me:
>> + *
>> + * entry (240) --call-> subprog_tail (1536) --tailcall-> classifier_0 (=
2048)
>> + */
>> +static void test_tailcall_large_stack(void)
>> +{
>> +	struct tailcall_large_stack *skel;
>> +	int err, prog_fd, map_fd, key =3D 0;
>> +	char buff[128] =3D {};
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		    .data_in =3D buff,
>> +		    .data_size_in =3D sizeof(buff),
>> +		    .repeat =3D 1,
>> +	);
>> +
>> +	if (!is_large_stack_supported()) {
>> +		test__skip();
>> +		return;
>> +	}
>
> The same pattern appears here: when is_large_stack_supported() returns
> false, test__skip() is called with no reason string. Could this also
> benefit from a skip message?
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/=
tools/testing/selftests/bpf/progs/verifier_large_stack.c
>> new file mode 100644
>> index 000000000000..2d4c81a3f0cb
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
>> @@ -0,0 +1,377 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +/*
>> + * Programs may use MAX_BPF_STACK_JIT (2 KiB) of stack on JITs that sup=
port
>> + * large stacks, combined over a call chain, with no separate limit on =
a
>> + * single frame. Interpreted programs and other JITs keep 512 bytes.
>> + */
>
> A subsystem pattern flags this as potentially concerning: Several tests
> in this new file appear to be 2 KiB versions of tests that already
> exist elsewhere in the same directory.
>
> For instance, frame_2048_with_may_goto is the same program as
> stack_check_size_512_with_may_goto_jit in verifier_stack_ptr.c
> (r1 =3D r10; r1 +=3D -512; r0 =3D 42; *(u32*)(r1 + 0) =3D r0; may_goto ..=
.; exit),
> with only -512 changed to -2048 and __load_if_JITed() changed to
> __load_if_large_stack().
>
> Similarly, single_frame_2048 / single_frame_2048_no_large_stack check
> the single-frame boundary that verifier_stack_ptr.c already covers with
> stack_check_size_gt_512 and the new stack_check_size_gt_2048 (fp-2056).
>
> The var_off_write_to_2048/2056 tests check variable-offset stack bounds,
> which verifier_var_off.c already covers (it gained
> access_min_out_of_bound_large in the earlier patch in this series).
>
> The private_stack_two_frames test follows verifier_private_stack.c's
> "Private stack, subtree > MAX_BPF_STACK" test, including the same
> __log_level(4) "stack depth max" / "subprog N (...) stack" messages.
>
> The BPF selftests guide asks whether variants like these belong as new
> cases in the existing files instead of a new file, especially since
> the earlier patch in this series (2d0faaadf6a8) already places its
> 2 KiB versions next to the originals.
>
> On the other hand, this new file does group tests for the 2 KiB stack
> feature, and several behaviors (four 512-byte frames that fit, a tail
> call from a 1 KiB frame, 1536-byte global subprogs and callbacks) cannot
> occur under the 512-byte budget, so they have no existing counterpart.
> Adding one verifier_<feature>.c file per feature is also common in BPF
> selftests (verifier_private_stack.c is an example). Could you clarify
> whether the overlap cases should be integrated into existing files, or
> is a new file the intended organization here?
>
>

I think it is fine as is.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359098=
53278

