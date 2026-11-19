Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061127;
	b=JD9CX+hin+BaVUw5r/8pQ2jjEznNKKj+S0QzRgaZs6/6p5C5vLv6u8mh95uL4F9Pxj3k
	 KfRLNblUwooSe+YteIwk1wP4tDPOpUy+87fvhR1HBFUpHfdCn7tVLUWSjKX0bc1afh0eJ
	 7u/TrazuZgBI27H1JZQfw6X3bfO9xLfvV8W5FkeZ+gLbeanM1wljdn45f+GayRj4df2Ho
	 fPhdooai7QfjiQFtDZAQOo+WzqlnQqHbmRZ7Pn2TxzUQNJdD/gyZvIsjPEZR8a01uKUSL
	 8sXfF5rjOJPF283PAvCYjknGO+MPcix2dzCzrHsQ7XeBxkONGvbUXrTx1Zav9Er9z1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061127;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Tpcr5Zp4BkOta5iOXgWYc2k+gGkUCm6BwSHGFg57Zz0=;
	b=ylmNv7PE/luisQK6qGtg2EIXyS6Qi881mg1M6/9yDJEpLoHibcYAnfe+UOAK4fNLGq3O
	 q0qsa6DXyeBfqUMdw9JcafHqOHgfciCeBMxToFqICflQZDeIu+NJ/o/vrNezsGLcQn3X9
	 vfkA5jD6CiEdYyj3vsvp1U40Wa0c+Kp0vUTpzvsgTXXleAKP62RQGWBneYnM5gYqIFfnO
	 +59K1VnSUGJtaZKckvPdMSLgCJEzN4GhLC3lRbBq/FElqfhuWyitaXnFOE+XWtlF4mWHJ
	 lKgZdssaKmfSFsuTUSpTgHMNCdzdg0jj8Seho3op1l6YbhrMubnGNCOHerxEZ4ezDDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5XhGT7m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CF606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5XhGT7m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A091F000C5;
	Thu, 19 Nov 2026 04:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061127;
	bh=Tpcr5Zp4BkOta5iOXgWYc2k+gGkUCm6BwSHGFg57Zz0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F5XhGT7m+NbsMg5nqX+4xMPFxCF8A0mJLdxk1oQAHinIv1FlH2xwsYZMXvOyRQ5i8
	 BDsDXh+c1ZJ+cbDz0oKl3pln5QHXOg6WLRAmki5JQtm2X2ouH77wiKwBIZwgnyijpH
	 DGDV7f0B5+7RCOsVLqNIsmFev50/A1hbNtFTcKnuisSTACnqFi/mtIJVx1natm7faf
	 I+pK8/ntYFhh5LvBC6bL5l0eiB+e1xbnUy1yeSvAxQpRMxYsYopvokb1LzTFtrGZxV
	 JC2vipz50Y/5jTku62Ym4oEERhN9gscsqjyd6/INZTLRqZ5iqBiIF4mt5iOmUAPI4T
	 uO/g0quLWLqsw==
Content-Type: multipart/mixed; boundary="===============5595045659735586197=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5e345f4c45d534dfd506ecc88fb295ef930d0317d3036845b478e215f1ab261b@mail.kernel.org>
In-Reply-To: <20261119033051.196177-7-luyun_611@163.com>
References: <20261119033051.196177-7-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Test wq callback setup after deletion and user release
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 04:05:26 +0000 (UTC)

--===============5595045659735586197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test wq callback setup after deletion and user release

TL;DR: Test issue: ASSERT_FAIL() in the new wq usercnt selftest may not record
failures, so setup, cleanup or never-reused cases could pass silently. Commit
message wording is a minor nit.

> selftests/bpf: Test wq callback setup after deletion and user release
>
> Use the existing NO_PREALLOC HASH map and callback to test that
> bpf_wq_set_callback() rejects a deleted value with -ENOENT.
>
> Keep the map alive through a program fd after dropping its last user
> reference. When bpf_wq_init() returns -EBUSY on a reinserted element,
> the idle callback survived reuse. Check that the setter returns -EPERM.
> On v3 the same test gets 0. Retry only a cache miss and report cleanup
> failures separately after attempting to delete each inserted element.
>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

This isn't a bug, but could "On v3 the same test gets 0" be reworded to say
which kernel behaviour returns 0 (for example, without "bpf: Check async
callback membership and user references"), with patch-revision notes moved
below the --- line?

> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c

[ ... ]

> +		if (retval == WQ_USERCNT_RETRY) {
> +			/* The cached element was not reused; try again. */
> +			continue;
> +		}
> +		if (retval > 0) {
> +			ASSERT_FAIL("usercnt stage error %d", retval);
> +			break;
> +		}

Can this ASSERT_FAIL() mark the subtest as failed?  In test_progs.h it
expands to CHECK(false, "", ...), and _CHECK() only calls test__fail() when
its condition is true:

    #define ASSERT_FAIL(fmt, args...) ({ static int duration = 0; CHECK(false, "", fmt"\n", ##args); false; })

With a false condition it takes the pass branch, so the message is not
printed and the failure is not recorded.

If the BPF program returns WQ_USERCNT_SETUP_FAIL or WQ_USERCNT_CLEANUP_FAIL
(failed update, NULL lookup, bpf_wq_init() returning 0 or -ENOMEM, failed
bpf_map_delete_elem()), the code reaches this ASSERT_FAIL() and breaks out.
Since attempt is below WQ_USERCNT_MAX_ATTEMPTS, nothing else fails and the
subtest reports OK.

> +
> +		ASSERT_EQ(retval, (__s32)-EPERM, "usercnt_setter_ret");
> +		break;
> +	}
> +
> +	if (attempt == WQ_USERCNT_MAX_ATTEMPTS)
> +		ASSERT_FAIL("usercnt reuse not hit after %d attempts",
> +			    WQ_USERCNT_MAX_ATTEMPTS);

The same applies here.  If all 256 attempts see bpf_wq_init() return
-EPERM because the cached element is never reused, the loop ends and this
ASSERT_FAIL() also passes silently.  The subtest then goes green without
ever reaching the bpf_wq_set_callback() -EPERM check it was added for.

The commit message says the test will "report cleanup failures separately",
but these failures, the setup failures and the never-reused case all end up
as a passing usercnt_reuse subtest.

Would PRINT_FAIL() (which calls test__fail() unconditionally) work here, or
checks such as ASSERT_LE(retval, 0, "usercnt_stage_error") and
ASSERT_LT(attempt, WQ_USERCNT_MAX_ATTEMPTS, "usercnt_reuse_hit")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44453425101
--===============5595045659735586197==--
