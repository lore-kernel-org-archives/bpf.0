Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77056286A5;
	Sun, 18 Oct 2026 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339411; cv=none; b=He3nlhOgc5XCv2gCdbqIctIQ9j18rWqAgBJ9j/O5/c0+t1CvWDEERaS4rwEl5tidzhBo/4yz9sCP/cZg9wwSoUXCAUEPAj7EHcD2darCYo/0/f2H6t69iF9XOgJURDYkPOANJKBxlPDWwLKJlJLlwJkff3J8Bjs9Hs8IlRbfaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339411; c=relaxed/simple;
	bh=f/OCCOh5rOqHZdsce+WhSqxvBWy4LVSUzzfUlU/ZZCA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hiRGMRJJObYw1PUSVkRcieG8tdAmTtl6IG23Jeo1EzvxhxsvjoZAKF5/XWtXcicvEgm4wZWxVvV918DXzPGLZRxx0vl72h3ZbVc4MRAU1ckapwDCylBVE8N44xJvVCY2lrPGkRjhoHimPMKmT0tQ9DLDJMGN1u2aHGRcfLnjpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5VhPibu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5VhPibu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12031F000C4;
	Sun, 18 Oct 2026 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792339410;
	bh=HYeP8TWpwRE5qcgc6J3SIe8N4tq7LKQGt0SkdyjyQ88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5VhPibuiZ7CXov7TdUVAls+KKz3aXR757ZAAcjaFbzoNOSYVFZQpQbxzzfoXT3Zt
	 M3313uS7/e7BNMc47/Xt4U29q+0IzvJKgBNBLo/U2LNEXp66N1DmvBk4PUeE/8bQng
	 MbP65SpIq7NC/36HkexQMfj+7UBqaAl/ZLobhqTc7U8Odw5Ib7pV+kDf3tuwm6dvaI
	 j5BQJpKoznTDTiznd+HQAZiWpVSzj8Oc1q0Rp8KXCOdi5gnCR4tuPab2nY9DI4SRlD
	 vVdG9l3LibWtZiQjZ58QAOxTyzBMu6L6dgwMsgAwqfZ4lDBpdutkNY8+mkQX/mgA0p
	 xX30yHIhi5dlQ==
Message-ID: <sashiko-outbox-176258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 next 03/15] kallsyms: Improve selftest
 test_perf_kallsyms_lookup_name() output
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Kees Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261018155206.132411-4-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
 <20261018155206.132411-4-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:03:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kallsyms: unused variable kallsyms_very_long_name when !CONFIG_K=
ALLSYMS_ALL
--

commit 3e15f2fb96b74e4386511b5db1ead3ae1d1fdf8a
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output

This commit improves the kallsyms_lookup_name() performance selftest by
measuring the faster of two lookups, verifying returned addresses, printing
an 8-line histogram of lookup times, and adding a very long symbol to test
two-byte length handling.

> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index 0db79237fe548..9072bd91c318c 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -29,35 +31,56 @@ struct test_stat {

[ ... ]

> +/* This is 509 characters, compresses to about 330 */
> +#define kallsyms_very_long_name \
> +The_time_has_come_the_Walrus_said_To_talk_of_many_things\
> +_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings\
> +_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings\
> +\
> +_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run\
> +_Shall_we_be_trotting_home_again_But_answer_came_there_none\
> +_And_this_was_scarcely_odd_because_Theyd_eaten_every_one\
> +\
> +_The_moon_was_shining_sulkily_Because_she_thought_the_sun\
> +_Had_got_no_business_to_be_there_After_the_day_was_done\
> +_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun
> +
> +static int kallsyms_very_long_name =3D 1;
> +
>  static int kallsyms_test_func_static(void)
>  {
>  	kallsyms_test_var_bss_static++;
> @@ -79,16 +102,17 @@ __weak int kallsyms_test_func_weak(void)
>  }
> =20
>  static struct test_item test_items[] =3D {
> -	ITEM_FUNC(kallsyms_test_func_static),
> -	ITEM_FUNC(kallsyms_test_func),
> -	ITEM_FUNC(kallsyms_test_func_weak),
> -	ITEM_FUNC(vmalloc_noprof),
> -	ITEM_FUNC(vfree),
> +	TEST_ITEM(kallsyms_test_func_static),
> +	TEST_ITEM(kallsyms_test_func),
> +	TEST_ITEM(kallsyms_test_func_weak),
> +	TEST_ITEM(vmalloc_noprof),
> +	TEST_ITEM(vfree),
>  #ifdef CONFIG_KALLSYMS_ALL
> -	ITEM_DATA(kallsyms_test_var_bss_static),
> -	ITEM_DATA(kallsyms_test_var_data_static),
> -	ITEM_DATA(kallsyms_test_var_bss),
> -	ITEM_DATA(kallsyms_test_var_data),
> +	TEST_ITEM(kallsyms_test_var_bss_static),
> +	TEST_ITEM(kallsyms_test_var_data_static),
> +	TEST_ITEM(kallsyms_very_long_name),
> +	TEST_ITEM(kallsyms_test_var_bss),
> +	TEST_ITEM(kallsyms_test_var_data),
>  #endif
>  };

[Severity: Medium]
When CONFIG_KALLSYMS_SELFTEST=3Dy and CONFIG_KALLSYMS_ALL=3Dn, will
kallsyms_very_long_name trigger an unused-variable compiler warning?

Unlike kallsyms_test_var_bss_static and kallsyms_test_var_data_static, which
are incremented inside kallsyms_test_func_static(), kallsyms_very_long_name
is defined unconditionally as a static variable in
kernel/kallsyms_selftest.c, while its only reference in test_items[] is
guarded by #ifdef CONFIG_KALLSYMS_ALL.

Should kallsyms_very_long_name also be referenced in
kallsyms_test_func_static() or guarded by #ifdef CONFIG_KALLSYMS_ALL?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018155206.1324=
11-1-david.laight.linux@gmail.com?part=3D3
