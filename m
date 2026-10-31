Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793488184;
	b=pxb5MaiOgAaCV86fm9CvGuuMBqKkQTQiTpiPCe0Vv6N1KmXaoQUUqK/DFdVnhoxEHSFh
	 IulpEFWjWzaJBYnwqXsRN0JU4Dzg/Ior2JN4YaowWeggc64VJYzrHMzeKgwfZo2h0Fs/t
	 qhCWCeD2H3uEH11ZW1V1kN48ekeBYrhfT7rMUyNHA5b7DjkO0yquUJ4E2UDsCGVbEy2Vr
	 hgs3wq3gt7wGh92pn1b2tQvBHTks6OS8zv/X01RMPxcKlaVqRiD1zxJv+Kx/UxInxWvAi
	 9fD/eeUyVNN4LJODy81A7jSl2iCBbuGxGrswp99ungSZIM4lNrC5rCN9T4uWBe5otGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488184;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1cGxzbwY1xMGMWgf/i6uVpCQTHumHxDjxfqNEmr+W+0=;
	b=C2oUbMZx2BU4HOmIUCf/txDtT+cjZLpS11sSH/MphsYw7z9y+45oX+D9vkREonJPP1F3
	 QG1IF8otb1efLxexCNV3PbdNJgfoDNkrhkciZnz6vRngWKcoeLnBeIPj3p5Xa5ks3j9n5
	 g+5Q/y61IRXsdf3hrteHHWf0Op+z/XVqtY3VYUgF5OzS2oAIgRMxEuY2P1PvRvrKznFG1
	 IuCXBn08PYrL3vELK/LPq4wb/7H5AlK2xnbz2jkjR6h/Pce/cu4zaHNLzi703vWsL4pFb
	 glFHuGptrhA5z/7odydbXgZ4VE4cSektVnSMf6wHGPku66jJ1rB827wi2un/5PX8ixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJsgWUYu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52286606A31A;
	Sat, 31 Oct 2026 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJsgWUYu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4031F000C1;
	Sat, 31 Oct 2026 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793488183;
	bh=1cGxzbwY1xMGMWgf/i6uVpCQTHumHxDjxfqNEmr+W+0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mJsgWUYuDp14mWJmblwTfh2ISNRs00vF6ckHrwZyJHOH3nsowMbwLunGf+SaSqFkK
	 5c7Mwuv9k0ayibibcpafXlpGskLoCoyJPVK+6PFMORZpDu7SSWTY+5/APJShunldrB
	 +Uy93eA0nmuPk0Ix9xQyo9whsyaBS5rVNeG+CyZARYZhrhz6jnI43d/syL+/+qxDxj
	 22FP5HIwDokmdQofCeZwUIpwjnqoJqwDm3WphLFccNS1yv1koGCFrkFVBi5CaImIT9
	 a/1Yis8UZS6Twc2k9w6i6UbLKsWnO3uXLjUiBksR9RUxNlP1ljM0OTfRec14trt8if
	 c0lcv6NwbpUmA==
Content-Type: multipart/mixed; boundary="===============4609840942152488716=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <52c900bde10157851ed039c75ab289e19221856c4e1422a6850c43743c4c5a80@mail.kernel.org>
In-Reply-To: <20261031223617.367-1-dennylin0707@gmail.com>
References: <20261031223617.367-1-dennylin0707@gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Preserve unsigned enum64 values in data dumps
From: bot+bpf-ci@kernel.org
To: dennylin0707@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,yonghong.song@linux.dev,linux-kernel@vger.kernel.org,dennylin0707@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 23:09:43 +0000 (UTC)

--===============4609840942152488716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Preserve unsigned enum64 values in data dumps

TL;DR: Possible incomplete fix: as requested in the v1 review,
btf_dumper_enum() was left unchanged, so an unmatched unsigned 4-byte enum
value like 0xffffffff may still print as -1 in bpftool dumps.

> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 3267163119dc..88c0da29f246 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c

[ ... ]

> @@ -204,7 +204,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
>  		}
>  	}
>
> -	jsonw_int(d->jw, value);
> +	if (btf_kflag(t))
> +		jsonw_int(d->jw, value);
> +	else
> +		jsonw_uint(d->jw, value);
>  	return 0;
>  }
>

Alexei Starovoitov replied to v1 that btf_dumper_enum() has the same
problem and asked for both functions to be fixed in one patch, and he
supplied a diff for it.  I could not find a v2 on lore, and this patch still
only touches btf_dumper_enum64().

Was the request to cover btf_dumper_enum() intentionally left out?

btf_dumper_enum() still sign-extends the 1, 2 and 4 byte loads and always
prints an unmatched value with jsonw_int():

static int btf_dumper_enum(const struct btf_dumper *d,
			   const struct btf_type *t,
			   const void *data)
{
	...
	switch (t->size) {
	case 4:
		value = *(__s32 *)data;
		break;
	...
	}
	...
	jsonw_int(d->jw, value);
	return 0;
}

For example, an unsigned 4-byte enum holding 0xffffffff that matches no
enumerator would still be printed as -1.  Should btf_dumper_enum() pick the
zero- or sign-extending load based on btf_kflag(t), compare enumerators with
matching signedness, and call jsonw_uint() for unsigned enums, as in the
diff from the v1 review?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41249994972
--===============4609840942152488716==--
