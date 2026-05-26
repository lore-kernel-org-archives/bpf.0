Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709D1A9F96
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819508; cv=none; b=Oy6oBsWR2T2zLbzqgxp0SW/2p4eABSJS4b3+4Qvej7k1m3QZCFb81N5CAfcwZtYjUQ+4OUewNc1Qr4r9vJr6MOPd4P0jxZ7oqxDvvqgckc16TwBpKfL5Tmfvo6sTRKu6DM9O7UOONG2STN+Io6OpkLxju4TgIxniq89Okigy0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819508; c=relaxed/simple;
	bh=4eGYRHrHaEPHG719BLY+KWtnIY2ZpjanjcKNH8ZLLbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qmMuCScmsQ5Z439aMka2XuFVOoTKh5FhqF8QXXAcCMQZl61kcn5LtxctyO6/OynDI+NRvvEgBMxEzJbgWoudmbQX8WT35axZcWQE8dktsxGRaKkfVhd4RRXTnV0dPcqz0yQDXcV3jsLlOljX+U2zYquU6uWy4D+HBx3zrZtur+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laDJYl7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laDJYl7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EAD1F000E9;
	Tue, 26 May 2026 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819506;
	bh=dlJygGh/ny7/9+r1HdxJNgt1ToyOc/t+TwmPQx0tk3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laDJYl7EsOPb+N227+Dd5p/2/BB9Ovwk0y0cs7dK+94V8jm9vktdRS5P6+W3WcBKi
	 /K0Vx+DN8VJnyTWspBGVxAj+kpYSiF5yPux1/Bj+dAJ8pzSsd3C934+qX1zBGon8yB
	 LkHcnkuBwTQ05QOHRIH2sxS8HN/H3wcfd7AGThGUd9ZyWngLuWw4p0nqnbV6Vo7PoG
	 Jh3Aio51tUNnRdEw43pWyXbqTGYXfc+LlOfT8zJ0/2IShavB2JqhXqXAx7QW2BDHL6
	 JzgJQjl3C/Up1HFjbiucIJ5ZtGH7knQrr4H2XZYw40kX5qP8YQNwqN5Jh3ChbVEHTx
	 IY5OcazpOazWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] irq: Add KUnit test for refcounted interrupt
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260526152148.30514-7-boqun@kernel.org>
References: <20260526152148.30514-7-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 18:18:25 +0000
Message-Id: <20260526181826.58EAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KUnit test assertions are executed while hardware interrupts are d=
isabled, causing a `GFP_KERNEL` allocation and kernel BUG if a test expecta=
tion fails.
- [High] The test suite lacks robust teardown and initialization to protect=
 the kernel from leaking disabled interrupt states.
- [Low] The KUnit test is unconditionally compiled when CONFIG_KUNIT is ena=
bled, bypassing subsystem-specific test configs.
- [Low] Missing closing parenthesis in a code comment.
--

commit ad24a2af47c3509344d4c410cf8820cb3d8e2b06
Author: Lyude Paul <lyude@redhat.com>

irq: Add KUnit test for refcounted interrupt enable/disable

Adds a KUnit test suite to verify the refcounted interrupt enable and
disable functionality.

Link: https://patch.msgid.link/20260121223933.1568682-7-lyude@redhat.com

> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index 86a2e5ae08f9a..44c4d6fc502ac 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_SMP) +=3D affinity.o
>  obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) +=3D debugfs.o
>  obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) +=3D matrix.o
>  obj-$(CONFIG_IRQ_KUNIT_TEST) +=3D irq_test.o
> +obj-$(CONFIG_KUNIT) +=3D refcount_interrupt_test.o

[Severity: Low]
Should this test be guarded by a subsystem-specific configuration option li=
ke
CONFIG_IRQ_KUNIT_TEST instead of CONFIG_KUNIT?

Building it unconditionally when CONFIG_KUNIT is enabled means the test
will automatically execute on any kernel with KUnit globally enabled, which
might bypass subsystem test configs and increase test execution times.

> diff --git a/kernel/irq/refcount_interrupt_test.c b/kernel/irq/refcount_i=
nterrupt_test.c
> new file mode 100644
> index 0000000000000..b4f224595f261
> --- /dev/null
> +++ b/kernel/irq/refcount_interrupt_test.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for refcounted interrupt enable/disables.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/interrupt_rc.h>
> +
> +#define TEST_IRQ_ON() KUNIT_EXPECT_FALSE(test, irqs_disabled())
> +#define TEST_IRQ_OFF() KUNIT_EXPECT_TRUE(test, irqs_disabled())
> +
> +/* =3D=3D=3D=3D=3D Test cases =3D=3D=3D=3D=3D */
> +static void test_single_irq_change(struct kunit *test)
> +{
> +	local_interrupt_disable();
> +	TEST_IRQ_OFF();

[Severity: High]
Could this trigger a sleeping in atomic context BUG if the test expectation
fails?

If TEST_IRQ_OFF() or TEST_IRQ_ON() fails, KUnit invokes kunit_fail(), which
uses GFP_KERNEL to allocate memory for the failure message. Since GFP_KERNEL
implies __GFP_DIRECT_RECLAIM, doing this while hardware interrupts are
disabled violates atomic context rules.

Would it be safer to save the interrupt state to a local variable inside the
atomic section and evaluate the KUnit assertion after interrupts are safely
re-enabled?

[ ... ]

> +static struct kunit_case test_cases[] =3D {
> +	KUNIT_CASE(test_single_irq_change),
> +	KUNIT_CASE(test_nested_irq_change),
> +	KUNIT_CASE(test_multiple_irq_change),
> +	KUNIT_CASE(test_irq_save),
> +	{},
> +};
> +
> +/* (init and exit are the same */

[Severity: Low]
This isn't a bug, but it looks like there is a missing closing parenthesis
at the end of this comment.

> +static int test_init(struct kunit *test)
> +{
> +	TEST_IRQ_ON();
> +
> +	return 0;
> +}
> +
> +static void test_exit(struct kunit *test)
> +{
> +	TEST_IRQ_ON();
> +}

[Severity: High]
Does this test suite need more robust teardown to protect the kernel from
leaking disabled interrupt states?

If a test case fails to balance local_interrupt_disable() and
local_interrupt_enable(), it will return with hardware interrupts permanent=
ly
disabled. Because test_exit() only checks the state but does not repair it,
the KUnit kthread will continue executing with interrupts disabled, which c=
an
lead to a system hang, RCU stall, or softlockup.

Should test_exit() explicitly restore a safe interrupt environment, and
should test_init() fail the test suite if it detects interrupts are already
disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526152148.3051=
4-1-boqun@kernel.org?part=3D6
