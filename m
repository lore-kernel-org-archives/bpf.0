Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F3379C42
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758055; cv=none; b=IvW3jvBzhM4xQPErzRUg4WojZHZ+EQANFgUbxb4IgPggqnKxRmNHj8g+g5ie1vGVEBEm23ahF/WeKCJUVXUW5ONPVA4DMcQtk6RVEs7OF+Hmrub/JnbnDu2Dz9FaDQqqnPOxX8aixxl8vKRe36/a97aggVn4bwLR0022AVei9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758055; c=relaxed/simple;
	bh=Mb4Zi4FhYXPvafxre44HTnBVfu+eJNVkbkpa53bXA8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gdEHovNW+rxZJlM4X0CYKEgxxnV3dUgA8KLk9NsHsvg79FkviuFu+gvkM1s0GAjLfbTiHbEDm86BXeD2Sj5rgVvjJcwtEAynAFiU/pm0yZWFHboQ69ge/ylETAVnfxu2mFfS3TOzGsH/fagv09oCSKjDA5oCAwTMzOw73dEmoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Q6mDncLR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Q6mDncLR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so420655a91.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781758051; x=1782362851; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwUky26FT/nTCe+WQP1PZFOZPyIRVsu6jmYMD3jo4Ho=;
        b=Q6mDncLRa8k/lQJAAnk6VeLzpilzX64u8/NwPivMAgoDqfhbrRhyCgKJE64lk3MRBW
         Joi83COXJ/UHkbUFlHF2k6dtMI/MiScbNhrMX6+AHB9MYoivs0+GZmSDUQS1jJXRu2Yo
         fBJODtYewRjRFkIF8r68MK82hvD0L/EUt1g/Yl3YpliJ86B6D97FWbpCsKhychKDduHj
         FSu72+fG/LLcpg4xiBbVsRJ2k4AIkrQRUUGQD+0iShujO6AMPJ9B31/ZbWsccoTGJLbl
         ceAlNP7K2YGkresIuxeehfhoUv7VuwExi7C1ZggD/eYP/2/N/ayhH5Tg6DHJVi/aftxR
         BSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758051; x=1782362851;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwUky26FT/nTCe+WQP1PZFOZPyIRVsu6jmYMD3jo4Ho=;
        b=UFXo1iHNZOs3VnWAMO8/Y9Xv6KAxRgBuA7i3BPAAeLxaJ1sIIHdhiB9zc5k7XeoJ9L
         1rxq+0FGtHvd/pVSVl9+S8keOCpgO1Xsra8NYLTEq3WG6/UywNy2UNYpESU04H2lYDuS
         IFTFpLNepPRkyMnhVmCm2Wf989YpCRg+1SCC2we6wyhQ9/mwvbBVu+jRnmjfEZb20hl4
         5Y3pYUL0uyUhZVnlbRz8WV1N7tFDbrs3DchmMCSHKzbXFiHqe81reDZhNMXjWBY5DX7/
         jaW+HND1f+V5HhLQ9AxadYbaO2z/244eR7JYeK6LVWoijK2Nu+83HqwYPprQh8TTwNUo
         Ie6Q==
X-Gm-Message-State: AOJu0Yy9h9fVDlg/kwSttX/+G3HSb/tK9LYhV+rIJSiXXatVpu0sa+zR
	iPNvqQyW7OsJilTmaHa2Stdcp6P7mqSbOz5Sj9Kq+2PbFvmnpWhSE4CizhTRiIrKC+U=
X-Gm-Gg: AfdE7cl1rt8IorEP2t2LWTDPEfovNNaffBJxqCGdSY5RzcLLt99xMnuVrWlk21O/4TQ
	MZjQXLIgodiBFoNnD7mxvOIDDwTPxO7ladfLh5h/RSoyKa3jWuL4Q85F7QEVqRlc+IDFSZq67Ix
	rmNJ/fctgZJPLhphtsNrdz0a+vCrcTLb73agtgdaZ/mL40jvJJUQRs4ZCMUyt8F6N4lJ7XWLCeP
	muGonuBCoSufjDDIbgoAcebNgR7X60a0zK0syZk/qrVdi8ZhXTWAlPxI0BlFIdySMOGb3LKP48g
	JyKGQLW6oKxk3/UZkDHXqWoxJHjB6FtRpWEs1NWz/P8tBstoJX1BXWPAskW4SHbX8iOL1YVMwjl
	ZTCnkJR7f3HLvYfdJc6R6rwtPSySZa5TNIlScVitOmUBEt7Mr2NEyPdsl73r0v/2HI6PLnlWxgZ
	yzLQ802FnWUaIQyKLcnXabVR2s8i0svXJd9rLywLMmNGwBOAC7U4FF/rY=
X-Received: by 2002:a17:903:2b03:b0:2c0:d8ee:7d66 with SMTP id d9443c01a7336-2c6e52b7e2dmr22128615ad.36.1781758051470;
        Wed, 17 Jun 2026 21:47:31 -0700 (PDT)
Received: from localhost (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8663352fd4sm15529055a12.12.2026.06.17.21.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 21:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 00:47:30 -0400
Message-Id: <DJBWIKFFVWDX.124XRXJK8VA48@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 5/5] tests: Add btf_type_tag ordering test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-6-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-6-vineet.gupta@linux.dev>

On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>
> Add a test that compiles a pointer carrying two btf_type_tags
> (__tag(outer) __tag(inner)) and checks the BTF that pahole emits to
> ensure the tag chain is PTR -> TYPE_TAG inner -> TYPE_TAG outer ->
> struct sample, i.e. the innermost tag is closest to the pointer.
>
> This exercises the type_tag ordering for both encodings: LLVM emits the
> annotations as child DIEs in source order (reversed when building the
> tag list), while GCC chains them via DW_AT_GNU_annotation already in BTF
> order. The test runs with gcc and clang when they support btf_type_tag,
> and is skipped when bpftool is unavailable.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  tests/btf_type_tag_order.sh | 179 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100755 tests/btf_type_tag_order.sh
>
> diff --git a/tests/btf_type_tag_order.sh b/tests/btf_type_tag_order.sh
> new file mode 100755
> index 000000000000..09d1ac346000
> --- /dev/null
> +++ b/tests/btf_type_tag_order.sh
> @@ -0,0 +1,179 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Check that pahole preserves btf_type_tag order when emitting BTF from =
DWARF.
> +
> +source test_lib.sh
> +
> +outdir=3D$(make_tmpdir)
> +
> +# Comment this out to save test data.
> +trap cleanup EXIT
> +
> +title_log "Check BTF type tag order."
> +
> +GCC=3D${GCC:-gcc}
> +CLANG=3D${CLANG:-clang}
> +PAHOLE=3D${PAHOLE:-pahole}
> +BPFTOOL=3D${BPFTOOL:-bpftool}
> +
> +if ! command -v "$BPFTOOL" > /dev/null; then
> +	info_log "skip: bpftool not available"
> +	test_skip
> +fi
> +
> +compiler_has_btf_type_tag()
> +{
> +	local compiler=3D$1
> +
> +	if ! command -v "$compiler" > /dev/null; then
> +		return 1
> +	fi
> +
> +	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
> +#ifndef __has_attribute
> +#define __has_attribute(x) 0
> +#endif
> +#if __has_attribute(btf_type_tag)
> +1
> +#else
> +0
> +#endif
> +EOF
> +}
> +
> +use_gcc=3D0
> +if compiler_has_btf_type_tag "$GCC"; then
> +	use_gcc=3D1
> +fi
> +
> +use_clang=3D0
> +if compiler_has_btf_type_tag "$CLANG"; then
> +	use_clang=3D1
> +fi
> +
> +if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
> +	error_log "Need gcc or clang with btf_type_tag support for test $0"
> +	test_fail
> +fi
> +
> +src=3D$(cat <<EOF
> +#define __tag(x) __attribute__((btf_type_tag(#x)))
> +
> +struct sample {
> +	int value;
> +};
> +
> +struct sample __tag(outer) __tag(inner) *global_ptr;
> +
> +EOF
> +)
> +
> +check_type_tag_order()
> +{
> +	local btf=3D$1
> +	local dump
> +
> +	if ! dump=3D$("$BPFTOOL" btf dump file "$btf"); then
> +		return 1
> +	fi
> +
> +	printf '%s\n' "$dump" | awk '
> +	function parse_id(line, m) {
> +		if (match(line, /^\[([0-9]+)\]/, m))
> +			return m[1]
> +		return 0
> +	}
> +	function parse_name(line, m) {
> +		if (match(line, /\047([^\047]*)\047/, m))
> +			return m[1]
> +		return ""
> +	}
> +	function parse_type(line, m) {
> +		if (match(line, /type_id=3D([0-9]+)/, m))
> +			return m[1]
> +		return 0
> +	}
> +	function check_ptr(ptr, id, tags, seen) {
> +		id =3D type[ptr]
> +		while (id !=3D 0 && !seen[id]) {
> +			seen[id] =3D 1
> +			if (kind[id] =3D=3D "TYPE_TAG") {
> +				tags =3D tags (tags =3D=3D "" ? "" : " -> ") name[id]
> +				id =3D type[id]
> +				continue
> +			}
> +			if (kind[id] =3D=3D "STRUCT" && name[id] =3D=3D "sample") {
> +				if (tags =3D=3D "inner -> outer")
> +					exit 0
> +				candidates =3D candidates (candidates =3D=3D "" ? "" : ", ") tags
> +			}
> +			return
> +		}
> +	}
> +	/^\[[0-9]+\]/ {
> +		id =3D parse_id($0)
> +		kind[id] =3D $2
> +		name[id] =3D parse_name($0)
> +		type[id] =3D parse_type($0)
> +		if (kind[id] =3D=3D "PTR")
> +			ptrs[++nr_ptrs] =3D id
> +	}
> +	END {
> +		for (i =3D 1; i <=3D nr_ptrs; i++)
> +			check_ptr(ptrs[i])
> +		if (candidates !=3D "") {
> +			print "type tag order mismatch; expected inner -> outer, found " cand=
idates > "/dev/stderr"
> +			exit 1
> +		}
> +		print "could not find tagged pointer to struct sample" > "/dev/stderr"
> +		exit 1
> +	}'
> +}
> +
> +run_test()
> +{
> +	local compiler=3D$1
> +	local tmpobj=3D$2
> +	local btf=3D$3
> +
> +	info_log "Testing with $compiler"
> +
> +	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; t=
hen
> +		error_log "Could not compile type tag order test with $compiler"
> +		return 1
> +	fi
> +
> +	if ! "$PAHOLE" --btf_features=3D+type_tag --btf_encode_detached=3D"$btf=
" "$tmpobj" 2>/dev/null; then
> +		error_log "Could not encode BTF for $tmpobj"
> +		return 1
> +	fi
> +
> +	if check_type_tag_order "$btf"; then
> +		info_log "  passed"
> +		return 0
> +	fi
> +
> +	error_log "BTF type tag order does not match expected order ($compiler)=
"
> +	return 1
> +}
> +
> +failed=3D0
> +
> +if [ "$use_gcc" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	btf=3D${tmpobj%.o}.btf
> +	run_test "$GCC" "$tmpobj" "$btf" || failed=3D1
> +fi
> +
> +if [ "$use_clang" -eq 1 ]; then
> +	tmpobj=3D$(make_tmpobj)
> +	btf=3D${tmpobj%.o}.btf
> +	run_test "$CLANG" "$tmpobj" "$btf" || failed=3D1
> +fi
> +
> +if [ "$failed" -eq 0 ]; then
> +	test_pass
> +else
> +	test_fail
> +fi

