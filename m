Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1153A8758
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142702; cv=none; b=O/PwaqjY2D69b/oizrnG2HgZrRjk3kcohX+k6tVx9APzLVtUQLq6dm4VBKp4LfD5woVVhKv2JnZssH9G92Ee09kTmvM4UADv6jDGzE/zm6JTPveetAg5nxyvbFEQIQl2Yw2BKxarxIcU+u4Kfj2UckaWTS5ztZG+L663Upxxf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142702; c=relaxed/simple;
	bh=2IDL0SRD/C6833WBi/fU/kAtA1EiUrZaaD9xYJDoZP0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EOKH8wnzTxwOcmgSWF8MzZDFSL4Okor91yirslE6JsyosKTFH6BrNK4Dh8MnmTFMONjxAK3BAQZ3Zy/VcNtGqp26TB9oXbh2cgxYdF8H0AO9hriG1UmzKSuTCDriaPrHsqIed2YjTqhmOvBtDBKORk70HUDGAkKkbG8xyc6nFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lix6zzLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lix6zzLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB9E1F000FF;
	Wed, 23 Sep 2026 05:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142701;
	bh=nX0234VsBSQnnSGtUSthoH1SdUi3UrbaVANFb/ivl5g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lix6zzLAxU+Cd8s3cLIRYcjbf6C3O4c/QGFedRoPQfeqJhtA22gWZeXOZ2S35eapP
	 vEmOD2BrksRzNOg3tNiTKUBQy+6g8f/OpMUYLGpKBlLGDTpwUJcGwpsCuUAyPsmx76
	 aJ3O5oGsL6BLKHEVSO5J+1R4gG1K5F5si+gjH9sAe8GwsiGVg8EAqWAeTu9fLVg+NS
	 VQNpPMMf/LrjKSbc6NdF9b6wHaGWhv3ZGMyVOYodGgwtj/LpAxklMoK42hvzMaswRm
	 gyss5TLkFn0ey4NDcoSKXAjK/0A38OkwqgjrsAi68lUGK4FeqedjhNRnABfq8sN7jJ
	 wTDqVEttmzTHA==
Content-Type: multipart/mixed; boundary="===============8402547545016243066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7b24a67541c588f4dd5c77610f5bba02e89e10a70102948bab8b8406f3f7e42@mail.kernel.org>
In-Reply-To: <20260923045917.2417421-1-yonghong.song@linux.dev>
References: <20260923045917.2417421-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 06/21] bpf: Make exception landing pads reachable in the CFG
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:51:39 +0000 (UTC)

--===============8402547545016243066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Make exception landing pads reachable in the CFG
>
> A bpf_throw() or a bpf2bpf call inside the [begin_off, end_off) range of a
> cleanup record can reach that record's landing pad. Add that edge to the
> CFG walk, which explores the pad and makes both ends prune points, and to
> bpf_insn_successors(), which liveness and the SCC passes walk.
>
> Liveness needs one more thing. When bpf_stack_slot_alive()'s
> is_live_before() says an outer frame's slot has no reader after the call
> the frame is suspended at, the landing pad can still be one -- and usually
> is, since only four registers survive a call and a pad reloads the rest.
> Ask about the pad as well when the call site names one; otherwise
> clean_verifier_state() poisons the slot while the callee runs and the pad
> is rejected for reading it.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix that completes exception handling support from
an earlier commit. Should this include:

  Fixes: 6e225ddc8aa6 ("bpf: Prepare for an exception cleanup table before the CFG walk")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============8402547545016243066==--
