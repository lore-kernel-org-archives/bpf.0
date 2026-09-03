Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E635CBD6
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476182; cv=none; b=FSd8XF8rF846VaefYupl9vcMQyMZf59ScSFCEo52TW6APmv7iCJvgFU3z+VHbdrSSENdV3Wr3/1CHxTaoqk7oamNIoDKBBYDH1x3jqkew/1csNyAdSbZyjVbTQVr1TbMjYucymULDcR5Le5ODfcDXnf1DkYdzdKlHoCFskgFHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476182; c=relaxed/simple;
	bh=P1ElIQbKzJGOVeDtOzaY2N/r7Baq4dl4cAV9ntAlA0I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=scpv1IzvLeDfjnky2jIitWXtPjjAcwPAWIuWoniRXvTASihqUH2C1nudimuRr9eU3YuUriI7qfUX7QUeIFqLgZ9hMy2BK9wgbaMjS15keQAz1L9llI8tkAizwtubXf/2qoNh5DUwZNrd3n2xVtv1sriNSaaNLWKYfI6KXsVJGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG4Dopk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG4Dopk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588381F00A3D;
	Thu,  3 Sep 2026 22:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476181;
	bh=P1ElIQbKzJGOVeDtOzaY2N/r7Baq4dl4cAV9ntAlA0I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gG4Dopk3ikH5/bJY0jWibL/uPpKL1eSNgT6SuzMXxMZRIkEoIlErTRxO/SyPBn+aP
	 KyIXSUIab4x5sLLSk+5widgW31wqoW4LZEk4u/4S0I7Xevrd8ZPV3Z33nFB0Vg/WcN
	 psFEnby/bENdiKTWtIAs6xf8KeKpinGuWLNCP1W/SVMqC3iz+Xa6Tg0FUK7ZIbaWa3
	 kEkKpL5SSC4MdwTlyjcOS2utGR6Zyvz0akfLB0Jy87yahLZaKlt8ejTVKGg72KloxH
	 oqnB2uRtpXuprygiXK8/OXutigo6uGic53xKGnOA5ASXO2G9/b+viwhv/CW8YWeGLk
	 hel/bSbt9hg1Q==
Content-Type: multipart/mixed; boundary="===============7076777226497522637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d56c8dfa6e4ca295e30c9d375e01ac2e83e2b98f323a2288dfff70722b76ee00@mail.kernel.org>
In-Reply-To: <20260903214758.2727663-7-memxor@gmail.com>
References: <20260903214758.2727663-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 6/8] selftests/bpf: Check faultable stack helper contexts
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 22:56:20 +0000 (UTC)

--===============7076777226497522637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add verifier coverage for the sleepable bpf_get_stack() and
> bpf_get_task_stack() implementations. Call each helper while preemption is
> disabled and require the verifier to reject it as sleepable.
>
> Both programs load when the prototypes lack might_sleep, so the
> expected-failure tests fail. Keep success controls outside the
> non-preemptible region to ensure ordinary calls from sleepable uprobes
> remain valid.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but the phrasing "Both programs load when the prototypes
lack might_sleep, so the expected-failure tests fail" reads a bit oddly in
present tense when the patch is adding the tests. It could be read as
reporting that the tree currently has failing tests, though the intent seems
to be explaining why the negative tests are discriminating.

Also, which pair of programs does "both" refer to when four programs are
added?

Would it read more clearly as something like "Without the prototype change in
the previous patch both programs would load, so these expected-failure tests
pin the new rejection"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33811770362
--===============7076777226497522637==--
