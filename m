Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722C35C681
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897759; cv=none; b=fB4/QtRTNxWwBogSqEtLzZ6Qh6JorkP9PDMLJhKNJv7hHVNqUjGh6Y69HMP03LWJsAqOFG/0TAZO6Y9+I4ubx6fRhGZYKdFDJ7sA2YvP0iQcZEJx7K5+R17ZwB5Xf/5i3RNiNXcqz2vziqZYTqONhguqG87DPE5HincSgR8sWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897759; c=relaxed/simple;
	bh=hy5DaRegCJlQD9CCuoxg9CvJ7LgMGAVCkqJHD+NDUBc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HbZobcOJSOWBcM3Hkkwwb7RhaItOsuw7vHqwGXrytXPp62kDmRjFDNR6rzk9PWqa8Y98Hyuo56v4EfbIlS/Z6IOJRUxTyJHKFYcfyWBDSbTYZmLEoc3iKvFC3BhIqd2GECP+b5tTDYwsee35tX1DYE7Wq8TrlhZb6QqPIo6+N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTGuxxkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTGuxxkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1DF1F000FF;
	Sun, 20 Sep 2026 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897754;
	bh=kR9ZxXat1+PynPm68AdzooRr4C306S/nSzAOjXurcG4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bTGuxxkjgdjlr8UTW3jOOXXsgtYntQwHYR98c/dI8K9eRuoQYFZ7evNzdAwP6SulR
	 wspce00Ch5CEdI6/wVZWobs78qnJw1v05QQ+WaaMhTitV7nt/Qf+jOlmyvIJ8pC8R5
	 Q0dubbwerNzYdL/EfG/30hBzrqInJngga3O6p/JWzCg6jg2hKMoW+uUNXUkOv3K19Q
	 HjfPbk8v3bdhnlRXurpyoulSI5fqYjqPXwfLOMwiRJnde2mjqvfqddk3OPcvdEf2U+
	 W3AK30kUBZkCHKenAenPMJZwDzl39nepaYVSVDlGgkqCym9Z0KOytJexF9mZWBk8Ro
	 NzLRMtcVKPmdA==
Content-Type: multipart/mixed; boundary="===============3526114758495915422=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b256fca1cae3f89250063e96a43c9601e9a3d4ff2567e28637562e74ccf2d09@mail.kernel.org>
In-Reply-To: <20260920085549.867099-1-madhav.khoslaa@gmail.com>
References: <20260920085549.867099-1-madhav.khoslaa@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
From: bot+bpf-ci@kernel.org
To: madhav.khoslaa@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sdf@fomichev.me,alexis.lothore@bootlin.com,madhav.khoslaa@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 09:49:11 +0000 (UTC)

--===============3526114758495915422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> csum_partial() computes num_u16 = len >> 1 and only sums that many
> 16-bit words, so the last byte of an odd-length buffer never gets
> added to the checksum. RFC 1071 says it should be padded with a zero
> byte and summed as one more word, not dropped.
>
> This backs build_ip_csum(), build_udp_v4_csum() and
> build_udp_v6_csum(), used by flow_dissector_classification.c and
> xdp_metadata.c to hand-build packets. No current caller builds an
> odd-length payload, so nothing fails today, but a future one would
> get a silently wrong checksum.
>
> Also bump flow_dissector_classification's TEST_PACKET_LEN from 100 to
> 99 so this actually gets exercised instead of staying latent.
>
> f4504af68575 wrote the len >> 1 division, but it only ever passed
> sizeof(iphdr), always even, so it couldn't hit the bug. Tagging
> bcc00987bc56 instead, since it added the first caller,
> build_udp_v4_csum()/build_udp_v6_csum(), that can pass an odd length.
>
> Verified with test_progs under vmtest.sh: without the fix, an odd
> TEST_PACKET_LEN makes the kernel drop the packet over a bad checksum
> and flow_dissector_classification fails; with the fix, both
> flow_dissector_classification and xdp_metadata pass.
>
> Fixes: bcc00987bc56 ("selftests/bpf: add network helpers to generate udp checksums")
> Signed-off-by: Madhav Khosla <madhav.khoslaa@gmail.com>

Should the Fixes tag target f4504af68575 instead of bcc00987bc56?

The tag currently points to bcc00987bc56, but that commit never touched
csum_partial(). Looking at the commit:

  git show --stat bcc00987bc56

shows it adds 42 lines to network_helpers.h consisting only of
csum_tcpudp_magic(), csum_ipv6_magic(), build_udp_v4_csum() and
build_udp_v6_csum().

The buggy code being fixed here was introduced by f4504af68575
("selftests/bpf: move ip checksum helper to network helpers"), whose diff
adds:

  +static __wsum csum_partial(const void *buf, int len, __wsum sum)
  +{
  +	__u16 *p = (__u16 *)buf;
  +	int num_u16 = len >> 1;

The commit message's rationale for retargeting the tag is also
self-undermining. It says bcc00987bc56 "added the first caller ... that
*can* pass an odd length", while the paragraph above states "No current
caller builds an odd-length payload, so nothing fails today".

As of every released kernel, no caller of build_udp_v4_csum() or
build_udp_v6_csum() passes an odd length. Before this patch TEST_PACKET_LEN
was 100, so udph->len was 108, and xdp_metadata.c only ever passes
iph->ihl << 2 == 20. The odd length is introduced by this very patch.

So either the tag belongs on f4504af68575, which actually wrote the
len >> 1 truncation, or the bug is latent-only and there should be no Fixes
tag at all. The tag as written points at a commit that neither contains the
defect nor exposes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35501508732
--===============3526114758495915422==--
