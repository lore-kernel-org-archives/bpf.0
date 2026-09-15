Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F84078D3
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487788; cv=none; b=bLpiqISzOGoIUKlpLMr1Vq4S4hzNuIZLfclOmHs9GoW2J4NvcHNEfSr1Suxmgn5IMygYf3ulBELBlNkds6TBNsiR2MqZ0mBIBgBrc8h91egdPCVti/exAm4zRBUP5/AhatwtiGPx2B7FTmTFnDljB6AQo96/LM11Ykb/EIm2Vrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487788; c=relaxed/simple;
	bh=oM/GT017hDXHH4AnBxW35OCzmaSr2ed4UtmHkslctvo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t/wtptuYQwKmItZcd9vc/WmCaBDewjdg3hTMrzhdZdm2sSMMF00gB2rrEbk8GT/IyfD5O37p5Qh+TZmaVtqiYvfy+vNYPUTmnAGnoDgQjeMDfDn/gO4eoEE3nxGFgbeuC6IOpmLjvSdqjUMTS84W3Aw7UKJOKLnKTwh2OHqoPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2BeKfeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2BeKfeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FF41F000FF;
	Tue, 15 Sep 2026 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487786;
	bh=xjzwYkIrgCTpxvS9KgWzLJ7N1+8mBre8HP52PbDf7Kk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W2BeKfeE6fO9p/SPZaoMI76Wrob/EJMdKPfI1x0Vw90NvETrjF5BJorJlueInSi9N
	 DhHjwWDFpT6jHE8iHMaGYhTECJol4RPVwZpXvfqhsJG3D1Hzxf3QE805gg8chf97As
	 K7DCV8ZHeRmywi63U5ymdOmICIL6n+Qt0NkFqgODCpyNO+9zTp+VBRVkGR460ALs2G
	 Xmxagy/h4tpsugsdKMCPOP2pLHgUyS1N55d+NsYyMotDO1pkyQS5bFqJaXa1AhEI40
	 Hc3lFVsRhpVI9Q6QjeMiold4lBmtdgA2/YGpg+yqw71zj5bqw3TtoV1ETCIQyYzJXo
	 Dm5llKBgNqtZA==
Content-Type: multipart/mixed; boundary="===============0682516533076523501=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58262a1911ba8265b8745e4a2f9e592ddfa74c814b4359a83fcf449ea32904fd@mail.kernel.org>
In-Reply-To: <20260915145054.164857-1-madhav.khoslaa@gmail.com>
References: <20260915145054.164857-1-madhav.khoslaa@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
From: bot+bpf-ci@kernel.org
To: madhav.khoslaa@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sdf@fomichev.me,alexis.lothore@bootlin.com,madhav.khoslaa@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 15:56:25 +0000 (UTC)

--===============0682516533076523501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 75133119c04a3..f6d28a2de7888 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -129,12 +129,22 @@ static __u16 csum_fold(__u32 csum)
>
>  static __wsum csum_partial(const void *buf, int len, __wsum sum)
>  {
> -	__u16 *p = (__u16 *)buf;
> +	const __u8 *p = buf;
>  	int num_u16 = len >> 1;
>  	int i;
>
>  	for (i = 0; i < num_u16; i++)
> -		sum += p[i];
> +		sum += ((const __u16 *)p)[i];
> +
> +	/* RFC 1071: an odd-length buffer's trailing byte is paired with
> +	 * a zero pad byte to form the final 16-bit word.
> +	 */

A subsystem pattern flags this as potentially concerning: the BPF
comment-style guide states that multi-line comments under
tools/testing/selftests/bpf/ must have the opening '/*' on its own line,
with the comment text starting on the next line:

	/*
	 * RFC 1071: an odd-length buffer's trailing byte is paired with
	 * a zero pad byte to form the final 16-bit word.
	 */

The comment text itself is accurate and matches RFC 1071. Is the current
style acceptable given that the surrounding file has no other inline
multi-line comments in this format?

> +	if (len & 1) {
> +		__u16 tail = 0;
> +
> +		__builtin_memcpy(&tail, p + len - 1, 1);
> +		sum += tail;
> +	}
>
>  	return sum;
>  }

This isn't a bug, but would keeping a separate '__u16 *' pointer
alongside the byte pointer let the loop body stay as it was, rather than
casting inside the subscript? Also, is there a reason for using
'__builtin_memcpy()' here instead of plain 'memcpy()' like the rest of
the selftests tree?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34986038731
--===============0682516533076523501==--
