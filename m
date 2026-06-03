Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7837F73A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519469; cv=none; b=DQFRd0CPdH4NMrdsGJ7L1CpTj/cUhSpK7+Z06DBYH6eQAWUFpPI7sfddLSkZyTjEzU/6x4fLccGGn0W0QAKo/4U6d3vtrQ4AWIKiAMndIeRVE3/gkU3LpsdrMpHBsoigeFbKGM3LP8mnfe1abuz4jHEQCeJiJcbdIV9dPKXMHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519469; c=relaxed/simple;
	bh=Xsxnu+t7r2JLJ+HvQNxgV/7N37onpmizU7YvE2O91Z8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Wjk7CTIK4Yw0Z9sJH6KqAv/UkrKb6PYqpRHfrzJxnR/3Hwl3bfJfIQuVvuepZ78K7yPmQsnyS4/xxZ7jOOVTL15q01BYuforR2LUxykn3BALYQslXLRFqjLwMw7+eFz3bR19J2xLEUqhU88qvAzpXk9v8IHjls7H9xU3G6ufPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wEguWJEb; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wEguWJEb"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137335bc3caso12147463c88.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780519466; x=1781124266; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49U9zuaCrRFc16K07IX5eMfLgjnW0VawFcMW+R70KvI=;
        b=wEguWJEb3Xlwgz1EZWtcX6RPsuriKVQe9wgGalGoRrVCUXxmlsmg2SC3hr0jfSwDf5
         AX4EKeDlKVmZoxqvsGunTsDGpSXGJlxG/KS+vQAFipZYBxRF4tRVEWalU1e0h6rJLKnj
         b6zoch1dSLiCDH/r/kzaAalJRtZAPfo4Yhbcgz06DTZPuZP9wur6yCTC20ICPoPGA6UY
         O5YMHZ8ybJESpooJoApQPAwDhKG4in7Y9tSdIhPER3qglVKEb+bbPzOQJexHjJVBKMWE
         +MJjASbFx2GmCLyt/QZMbI3BCU+lpL+AEWFZh7d+gOf+BBHeNetadPoEFlv9V3ZSL0bX
         PxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519466; x=1781124266;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49U9zuaCrRFc16K07IX5eMfLgjnW0VawFcMW+R70KvI=;
        b=rb+WGfZo9iTkVqo46zl/vXgwYJs35rNaAFk5+XUKOvpYKrFFcCBy/KywKaYuza9RL7
         P2Mf87SbrHkPwh/IcC6OFG8iAB1ETLQ+aUl4Nu+7X2cQivq8Wh5svuHIwe3jESo6Y08v
         8eXarclXYAkj4RMYz5uFJySWMpLqCpWyShQadvegEV2MKziX2xjX8I71IoaB3oVRUYyo
         raR6YgpIURV1DkuV0qNQVrp/noiNrTZv0WTVvvG+B46W7GRukKlDEnajPETOcnmPwo4F
         bP0WbCDrTKvSSyoDmuZKTulrXdT46BK8e+LPvwlK5KHB6Sz7shmI7sJ8gSkAjpC9E67J
         1aiw==
X-Gm-Message-State: AOJu0YwE3Q4xdnj+xk3Pd+4mJDeVGhq5agUbD4D7ynpP4sgYa+/GeJ/6
	6jEyzjFQjyCXcV/wlR9qjQdrCZXY62s9V41T+g2xaslJkhfARZwXKeCx0/eHkw07+ko=
X-Gm-Gg: Acq92OGuXXmGG7hcx6k2GCA67WqMOJ1CPmJQM0TwlIJgqJECcMIYOd8LBcoxg7YhbTR
	HE7dL0U0GVYST/VexbU4s7Lf3Whh17OFh6XBFa6x4lO4mietJFBiSc9w7EPs+qhGqzoZoDcyEc3
	lgPSlplhiWf4qNGz55tDcRKykrS3hWCBQGc3xI6kQqZdc1ZgT3ISv/+aiLveGMkb7ARFj7GPVoe
	ixChNyGH9tVfc+2qs+HoQjEP88RbNvKo34G9z8tErW0XSAqZzXy4K/CzzazVoz64xHtvlk9ZuSo
	+BQCWQzFAKyAKFXdWgHBbttLcP7sYdmsdcf8mwVk7C8vbVefhDWzf/PGCA2PpPH4QfM/r8BdHDb
	lGaZ3W2Qc/dYniDKCfvW7vr2AKfgzbi1scEjYWYZnWITcSBSoSRbxAA4A6FsBhGIuAeObzEdFpY
	Z7avXYs3m8Ia4AB2o=
X-Received: by 2002:a05:7022:60d:b0:130:760b:77aa with SMTP id a92af1059eb24-137f6c25649mr2259484c88.41.1780519466200;
        Wed, 03 Jun 2026 13:44:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4ada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm3108451c88.15.2026.06.03.13.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 16:44:23 -0400
Message-Id: <DIZPH1MFO1TW.NPPNVHBBCMHT@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v4 3/3] tests: Support GCC in pfunct-btf-decl-tags test
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-3-vineet.gupta@linux.dev>
In-Reply-To: <20260602195512.1511013-3-vineet.gupta@linux.dev>

On Tue Jun 2, 2026 at 3:55 PM EDT, Vineet Gupta wrote:
> GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation. Update the
> test to run with both GCC (>=3D 16) and clang when available, instead
> of requiring clang only.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tests/pfunct-btf-decl-tags.sh | 72 +++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.s=
h
> index 35884b4e8687..a46aa1f3df55 100755
> --- a/tests/pfunct-btf-decl-tags.sh
> +++ b/tests/pfunct-btf-decl-tags.sh
> @@ -6,24 +6,36 @@
>  source test_lib.sh
> =20
>  outdir=3D$(make_tmpdir)
> -tmpobj=3D$(make_tmpobj)
> =20
>  # Comment this out to save test data.
>  trap cleanup EXIT
> =20
>  title_log "Check that pfunct can print btf_decl_tags read from BTF."
> =20
> -# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
> -# in upstream version 16.
> -# UPTODO: add a check here for that.
> +# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac702=
7f180b).
> =20
> +GCC=3D${GCC:-gcc}
>  CLANG=3D${CLANG:-clang}
> -if ! command -v $CLANG > /dev/null; then
> -	error_log "Need clang for test $0"
> +
> +use_gcc=3D0
> +if command -v $GCC > /dev/null; then
> +	gcc_ver=3D$($GCC -dumpversion 2>/dev/null | cut -d. -f1)
> +	if [ "$gcc_ver" -ge 16 ] 2>/dev/null; then
> +		use_gcc=3D1
> +	fi
> +fi
> +
> +use_clang=3D0
> +if command -v $CLANG > /dev/null; then
> +	use_clang=3D1
> +fi
> +
> +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> +	error_log "Need gcc >=3D 16 or clang for test $0"
>  	test_fail
>  fi
> =20
> -(cat <<EOF
> +src=3D$(cat <<EOF
>  #define __tag(x) __attribute__((btf_decl_tag(#x)))
> =20
>  __tag(a) __tag(b) __tag(c) void foo(void) {}
> @@ -31,7 +43,7 @@ __tag(a) __tag(b)          void bar(void) {}
>  __tag(a)                   void buz(void) {}
> =20
>  EOF
> -) | $CLANG --target=3Dbpf -c -g -x c -o $tmpobj -
> +)
> =20
>  # tags order is not guaranteed
>  sort_tags=3D$(cat <<EOF
> @@ -54,16 +66,44 @@ a void buz(void);
>  EOF
>  )
> =20
> -out=3D$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> -d=3D$(diff -u <(echo "$expected") <(echo "$out"))
> +run_test() {
> +	local compiler=3D$1
> +	local tmpobj=3D$2
> +
> +	info_log "Testing with $compiler"
> +	out=3D$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
> +	d=3D$(diff -u <(echo "$expected") <(echo "$out"))
> +
> +	if [[ "$d" =3D=3D "" ]]; then
> +		info_log "  passed"
> +		return 0
> +	else
> +		error_log "pfunct output does not match expected ($compiler):"
> +		info_log "$d"
> +		info_log
> +		info_log "Complete output:"
> +		info_log "$out"
> +		return 1
> +	fi
> +}
> +
> +failed=3D0
> +
> +if [ "$use_gcc" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	echo "$src" | $GCC -c -g -x c -o $tmpobj - 2>/dev/null
> +	pahole -J $tmpobj 2>/dev/null
> +	run_test "$GCC (version $gcc_ver)" "$tmpobj" || failed=3D1
> +fi
> +
> +if [ "$use_clang" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	echo "$src" | $CLANG --target=3Dbpf -c -g -x c -o $tmpobj -
> +	run_test "$CLANG" "$tmpobj" || failed=3D1
> +fi
> =20
> -if [[ "$d" =3D=3D "" ]]; then
> +if [ "$failed" -eq 0 ]; then
>  	test_pass
>  else
> -	error_log "pfunct output does not match expected:"
> -	info_log "$d"
> -	info_log
> -	info_log "Complete output:"
> -	info_log "$out"
>  	test_fail
>  fi

