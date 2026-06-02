Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C152848BA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362337; cv=none; b=N84vDlvSY268LwXyStJx+9MJh+hJG16Ri1Symwd8J1Q58+f036OmFWvEGqppmKw5X5YA1+6hhckfUXF3RffGQmJT41amtLezX84rWPs4aZ3t29Wuch+MfbnE7SDQxGYv+lAPw6MP2WXVQsKo22ecVR9uOYsQ+ztpLR4l3ntaCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362337; c=relaxed/simple;
	bh=ToHc5GxUKwINZrR3fzfLrAxSuFarAZPeqI5xQbIJZDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G8gI576Nxhw1HIx8/Sce7US/9HQ4vNbaz51u4AO9hZdMEDLd4ZAzlbOMg/BI38Y1eMLt1E7NDiWgGFGkr4uTdR8CrJmzdKAh1PDSaKIogkWlSePL2Io421W803mdbPaH20Mm3ugoJTp7foJLaX5lYfCgC9U/kxzFDoKOR4IqvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eCTUpvuV; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eCTUpvuV"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1363fe80fe8so12905492c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 18:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780362335; x=1780967135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZQoA4UaQO9wE6A7Q5YCAeXhGRjXxFgUqc5coKVMKck=;
        b=eCTUpvuVkbHsNZygE5qK5jOmWYhAGg+DkgrMvI/zcsyVSLwTh8+IOxaOUwEoKyMkMf
         hb+NNcwJx7i1spFZafRgcb3g+D/FSD4QWwvGSuL1UYbiHoaIv3hxe4+NFUxfGerZ38ff
         CUJur73eWU6tM9xNWVHNrgBLxqj9jKto6BbH5mUyp93jRihz6rWpyY0948l7lbHPu96T
         zmVDcl0QN1ge2AyK4TOPNQr1HyRqn+hWYX9m1mI/6vMWrAs4+ueFvvH3iYDOaSh0n6JM
         kZ7DjiUqLaZ9VTbIMLi+eONbScn09oKfdVCudfpbJ5CJzlTQdXB/F9NzHJe/LWcOGKen
         4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362335; x=1780967135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZQoA4UaQO9wE6A7Q5YCAeXhGRjXxFgUqc5coKVMKck=;
        b=nNYnlwkdPcHHbKKYnF7p8F0cw/b0A1y+tyRhauvF+EH73hDcHloHuatJ6Vl4dTkCJq
         P8HHsF5505GY3QAVgcJyrC2Usc3gq8I49C7PJKxhaHr3UZQF9nYYTJUXSSqLcNVqIRl9
         5Kktr7zUn2WdKUc802i+RXdG1mwEM76g9iX8lwtlghgjOuuIxys7ftREjk3zNaBOjUY7
         1LJIEHjcW/f3vqYtPnJ1R4+IQLTCgLvTyL0xDlxamfC+UpRKBrX0BorFCnNCqV9YJ3Y/
         CPX9b5mggnwVafi55ohQTSgT3aVQQy6OufVifNS8yPGIW4PXkSSay4QxmvBBZRk6Df3g
         nuuw==
X-Gm-Message-State: AOJu0YxoASzqWWIKTLadpVfu7k/9qs0QmvsrYNbwyp+UipWfqapWboeR
	5SEDO75WztyqEvnDuIijfISvIP2n4CezgbH8cDERRKYte+4llvQ80WkvbuS16kydVQE=
X-Gm-Gg: Acq92OEBnpxhkgmKF1O5nR4vShtI8GrU+qv0GYlGmLQKk5+7ePf8uOunsV2KUaNF147
	odNGEpPsxC8rBE6wYnRVqZKd2siAiJqn8dY77Lhub0URuBqocsQWbkp0o/5a0K6fZh+4wELis0e
	2jsIHrCPX6bpbiulARpmFVMva2isOOqHiY0BqY/0b7odoAQ+kGas3xN8hRenc6C9gvoJJmz1cQc
	tLumAFmZDcrNZFRx+MpKBaZs/Gr7h8m9KsDLyEIsJRadHQPKWcrtSZLKqwmEJugjVyvDvTZq1rN
	Qvgs3n6N5GgnUT/5g9jFFbtOM3gt/pD9/EfnvOjJ6SOGSTWpl3dFNdkz1b8kvKp19SbOXfbtEGF
	gEApgrvqoAkDyPOKhXaJ7X3aI3inq6U8DyIH01HiY10Ro1lCcHv/gS8c7/XnPdtBWy5vtcCL26E
	BRKt/uHRBmDuDqhb38ahtWpU0quQ==
X-Received: by 2002:a05:7022:f502:b0:137:ddaf:7e89 with SMTP id a92af1059eb24-137ddaf7f47mr2297872c88.15.1780362334922;
        Mon, 01 Jun 2026 18:05:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3d8f839sm7441673c88.15.2026.06.01.18.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 18:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 21:05:32 -0400
Message-Id: <DIY5RWLRH7C1.8YT4ECR1ZALU@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 <jose.marchesi@oracle.com>, "David Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v3 3/3] tests: Support GCC in pfunct-btf-decl-tags test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <20260601183511.594100-3-vineet.gupta@linux.dev>
In-Reply-To: <20260601183511.594100-3-vineet.gupta@linux.dev>

On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
> GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation.
> Update the test to run with either of GCC (>=3D 16) and clang.
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

