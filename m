Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A73D47C5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638796; cv=none; b=da8WYbh6Jlms6ctHrHZu2/IX+1Kc5bp0ihESj0wEewC7tlBFi7SvgYlNpO0Qryzdl3kgpx9i8z2goePVkM4GnbJkrNOwfijJUFYBdossS2bn14igd1kOYwmXJGFj/dbmNtIZz1+ZOsZNN6U1c+1oQvmVXhNb2MGw2cm6e9+aveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638796; c=relaxed/simple;
	bh=y0EMCtOZCNh68tYIBU6tLq7q+1GHTtjxWejFQ+WlNr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRcmchuesJcyPWlSl43OwcwDsmSYKPysDJ9K6PetJVsGxC0wQwreC7qND4lBe7xttKMJQmqsI8GLNRWulTUM/No1gsVNfh+zTlQZMEMW3H/umjhGTjxnUtgFZqUJhy/93zGeU2eOwJ8Me8kKFWwkDUCloV6YmpiBY6MLgP50YmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lml7UiNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lml7UiNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E96E1F00893;
	Fri,  5 Jun 2026 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638795;
	bh=/9CbwCWsi34gkwKm8hLHvM6OdjcQ7a7S1CMX06rPhV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lml7UiNl73VgvGa8IQTHWt5ReW9Xo4rn5cxgBQ/D9SHlnMLseMy41+ub4zjFmjU9g
	 by6YkhyojlIu/ZCaCQVWBHt0QrksQGStZO1fYgXoNT+OpcFGq41Jzsg9qtK4/3oqgf
	 gmoEbsmui9Mnzqkxa5CfPkwoflyT/x5CLwGpN5pxkUY3gL8FUKOvt0W21oQGdNjiyN
	 rXCpk3dpCz4erywC8fbT0bcDv4sYnnPERShhsfbtL4nzStoOqKWZoZ+h6faGsLiqFx
	 pSnnQD2PFQGiCokYrivOQElU4Vzlk5sWKEAZ66A1Ll2W3cOEOVM4BhHgqiJBBKB53d
	 IJShdDp7rgfZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] irq: Add KUnit test for refcounted interrupt
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605054128.5925-7-boqun@kernel.org>
References: <20260605054128.5925-7-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 05:53:14 +0000
Message-Id: <20260605055315.3E96E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The refcount interrupt test is unconditionally compiled and execute=
d whenever CONFIG_KUNIT is enabled, causing unnecessary kernel bloat.
--

commit 0f70b0c848721241ef0e28b62356b6ec7b9daf4b
Author: Lyude Paul <lyude@redhat.com>

irq: Add KUnit test for refcounted interrupt enable/disable

This commit introduces a suite of KUnit tests to verify the behavior of the
new refcounted interrupt enable and disable functionality.

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
Should this test be gated behind a dedicated Kconfig option instead of
compiling unconditionally when KUnit is enabled?

Using CONFIG_KUNIT directly forces the test to compile and execute whenever
the KUnit framework is enabled, even when a user is testing unrelated
subsystems.

Could this reuse the existing CONFIG_IRQ_KUNIT_TEST (like irq_test.o on
the line above it) or use a new, dedicated configuration option to allow
granular test selection?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D6
