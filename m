Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC711E89C;
	Fri,  6 Mar 2026 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759817; cv=none; b=aIOGrj1kkoi44ERjBF6PmVb1Sh1C3IVO9RYCytgOctC7XPGmy+14TkTaM9NR76N6RKD55rWvtvRmVmZH2wQC0fiNT6vXmr7ldU2+GObPmEcD+IqMNKJeRhAnwFaR6WijLA2BzuID1gxMyC+aJJFAqeDDcQnq8YOz48yRbdeF/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759817; c=relaxed/simple;
	bh=XHe3bqQF1TXr1bvmZLA2gqmqdCXluKv2sMBgo6vYN70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgrxK4BMtBykeegp1cQ+qn20okS7DJiY45S+O6hLsRmNQKUJFff2m2XjIVRqVkuW4l4rhnq1ecuHWif3u1Zmi+HMU5p5t0cLIJ1YnTTAApO4oa+MBDs6XIrCJHI2R6pH+ee6e3ner8r54ZXtDvEKoDn5DzeELcCKSZG1BrHO7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VfztiJzs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VfztiJzs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772759813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kqcm7Z2shZIKcebTa2M2yVzMFVleSUUyn7osg/dyLAo=;
	b=VfztiJzsvbtLZ9usoRJLPAKM0wGbuGwAfHCKQL41uzcRKkLYbio1T3DOod83Ikm9ghQmKN
	ZslXMvH/Edy+1Sj+76VyXPzC1P01sBhWR6yoHA+BQizjSM2r8nwLGeMmig6HHcVZfnPTvy
	l8tCygYE9bd77K4PfcGM9xAzNyCH2D8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, toke@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 varunrmallya@gmail.com
Subject:
 Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in
 fexit_bpf2bpf.c
Date: Fri, 06 Mar 2026 09:16:41 +0800
Message-ID: <12848362.O9o76ZdvQC@7940hx>
In-Reply-To: <20260305222132.470700-1-varunrmallya@gmail.com>
References: <20260305222132.470700-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/3/6 06:21 Varun R Mallya <varunrmallya@gmail.com> write:
> Building selftests with
> clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
> the following error:
> 
>   tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
>   error: assigning to 'char *' from 'const char *' discards qualifiers
>   [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> 
> The variable `tgt_name` is declared as `char *`, but it stores the
> result of strstr(prog_name[i], "/"). Since `prog_name[i]` is a
> `const char *`, the returned pointer should also be treated as
> const-qualified.
> 
> Update `tgt_name` to `const char *` to match the type of the underlying
> string and silence the compiler warning.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 23d933f1aec6..92c20803ea76 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
>  		struct bpf_link_info link_info;
>  		struct bpf_program *pos;
>  		const char *pos_sec_name;
> -		char *tgt_name;
> +		const char *tgt_name;

I have been suffering from this build error too. So,

Acked-by: Menglong Dong <menglong.dong@linux.dev>

>  		__s32 btf_id;
>  
>  		tgt_name = strstr(prog_name[i], "/");
> -- 
> 2.53.0
> 
> 
> 




