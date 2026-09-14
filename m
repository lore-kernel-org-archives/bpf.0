Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A147FAFF
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396241; cv=none; b=tu5miPLYzNbMenp2Ipy226xMYLASsIj9ll7aM9D1E1CxWmGplL6fX+/EdfaKHQ2PszNHSrtgjkCzLLXmIXLTrAf0sgulOKMYTAAHdNTlPVNAVzp1jKF4pe+tl2JM/iZuIG8fMx6bWT/5soPPaIr5D4GjZJIW8+wjQbSwuZAFZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396241; c=relaxed/simple;
	bh=CEQuiGqdanYS96z1ULqReH0rZk2KRCghSPUor7KD12o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U1jaHAvURzA0nymNBg4ymo3RybN1mKoyn5QQOLO2+mzBCogWhFtJjQuovB0/pV1p4AwUPBqMHh19OZH2s59pb1Do9zOi3AEAXxTYAkzAvHZy2KwD3NUc8NQ2AwSUpGZQlL71XDf/78JZ3gfae1r9kAqo8lC4FqNVaGt/gBJhykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8r8lCq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8r8lCq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC3B1F000FF;
	Mon, 14 Sep 2026 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396238;
	bh=bz9Sve09Yv07gcoYOe79eeThTssEtpUg3mKDSWBPEmE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B8r8lCq0Yj0Mq9+8mZMnh3Bcd241QSslZJI9azN2jStL1/UI404ep2giBN1NTJck5
	 jO03CsCBCefsS9I7lfzIa5+6uh3EVi39/07QgoG0WSm6eA3lvv1gHjbBrIc6i3BXt1
	 Y8qwEWlFE+wG+ZHQ2UPfMRGNTCkT5gRRtSQLGuTyrSMQPoJHEIxvw6r+kYJsDYcjDs
	 99ahFrSh8bZj/4oF4N9hzbTBFcN+ROxxxNnINCEEpFksyJWDhTGnFz11tStX0IjT5w
	 10Y6mZ3P5WP/SUY/yQwc588Fc3FkflpR2DJSjpkCgZQzDxI/HKuUnmOzRbJ4aaV4e8
	 PpVmQemsiAh1g==
Content-Type: multipart/mixed; boundary="===============8773895153830472993=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b4c65c7d859e59c6cfbf25eb35d513a5b509dd8143ded4c8ba0d5f5b86b0d37@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-7-memxor@gmail.com>
References: <20260914131701.2529725-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 6/7] bpf: Assign lock identity to callback map values
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:30:37 +0000 (UTC)

--===============8773895153830472993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d0..8f769ee14bd65 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -46,17 +46,10 @@ struct bpf_reg_state {
>  		/* valid when type == PTR_TO_PACKET */
>  		int range;
>
> -		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
> -		 *   PTR_TO_MAP_VALUE_OR_NULL
> +		/*
> +		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY and PTR_TO_MAP_VALUE.
>  		 */
> -		struct {
> -			struct bpf_map *map_ptr;
> -			/* To distinguish map lookups from outer map
> -			 * the map_uid is non-zero for registers
> -			 * pointing to inner maps.
> -			 */
> -			u32 map_uid;
> -		};
> +		struct bpf_map *map_ptr;
>
>  		/* for PTR_TO_BTF_ID */
>  		struct {
> @@ -155,13 +148,20 @@ struct bpf_reg_state {
>  	 * gets parent_id set to the dynptr's id.
>  	 */
>  	u32 parent_id;
> -	/* Inside the callee two registers can be both PTR_TO_STACK like
> +	/*
> +	 * Distinguishes inner-map lookups and their keys and values. Zero for
> +	 * other registers. Kept outside the metadata union for ID remapping
> +	 * during state comparisons.
> +	 */
> +	u32 map_uid;
> +	/*
> +	 * Inside the callee two registers can be both PTR_TO_STACK like
>  	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
>  	 * while another to the caller's stack. To differentiate them 'frameno'
>  	 * is used which is an index in bpf_verifier_state->frame[] array
>  	 * pointing to bpf_func_state.
>  	 */
> -	u32 frameno;
> +	u8 frameno;

This isn't a bug, but would it be worth leaving the frameno comment in its
original wrapping so the hunk shows only the new map_uid field and the
frameno narrowing? The comment body is unchanged by this patch but is
reflowed from the '/* first line of text' opening used by the rest of
struct bpf_reg_state to a bare '/*' opening. The same reflow is applied
to the map_ptr union comment. The behavioral part of the hunk is the new
u32 map_uid field and the u32->u8 frameno narrowing; the comment
reformatting is orthogonal to that and enlarges the diff.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============8773895153830472993==--
