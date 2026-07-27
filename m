Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FF3BCD2F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121652; cv=none; b=IU7TEk4w22JLDbP4ww8H6s3d1QXhNHWiOaPF0JcEDQG9e1piQcEDSeI0mopRGfY4pSO0CsfyaHOidApM5a1J5BtJYGWoV3vyk7aPGfaOzg68Rgwpdrvv6EI3fmkEj1dQuecjEm5xk8wg8vq5Z2tH7QEHbF6PuqPlAKP4c3aHX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121652; c=relaxed/simple;
	bh=R4jZYgQ/fKuwjHeOJbmkQ0tf+cBND9BfMKJNy2QQ8ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l39pkSLrvyZ2UhU897latPvIaErayum/imMDKy+0SQPZcnhDcbILKLVg0cTr+zgbHDqbHLDcQ4duczWzzY88P3M2GLoGoWZUm8hEI3/27tHX+V5cg/e7rFzGp0TqhPE2YYK0LpakXlsmrpC3fKGVJkGz3oWNAGq5ks5oolDUyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIjHNk4D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIjHNk4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121651; x=1816657651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4jZYgQ/fKuwjHeOJbmkQ0tf+cBND9BfMKJNy2QQ8ww=;
  b=CIjHNk4DvUHwhEPGJfHWlp7i6H5wRM1n40pdr5etnoFH+DoFv6SRJ6ZA
   U+kqCVmDTaZcWSHSCOnP1ltb5dpVL/wDOdSAwfzM8NmNoZXmApTQNpX2v
   fgrLFnst8hVlD8K+O3Pdb0UdOo3vg3+8voBjASPaa54EMazjYZUxX9/Nh
   u0Q2N3KMC9xtlJ0XgGyg01rRFzLngJq4U6RlvcaOQlsTf8lRr/mz6yBql
   Jr+VP9E3nyi/6fH0mfZeMu9TAmYpxOwIyO2L1UjMfymGXchoCntSPZ/aB
   7SeWVurdpix9VCsghqfo4UnQAWz//tnd8XYeS/4Gsk8BDGmkUJGQ+jaz8
   A==;
X-CSE-ConnectionGUID: RzshlKYFTT+hMN/P7K4MkA==
X-CSE-MsgGUID: Fqf+yFeFRhCr8UHgYGeVVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="84664763"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="84664763"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:07:30 -0700
X-CSE-ConnectionGUID: 63mVG81lTZKbAe0xXD+zNQ==
X-CSE-MsgGUID: OWakmYaQSVCqAEYTmPo8Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="297514441"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 26 Jul 2026 20:07:29 -0700
From: Tao Yu <tao1.yu@intel.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com,
	tao1.yu@intel.com
Subject: Re: [PATCH] bpf: normalize arg_track state construction
Date: Mon, 27 Jul 2026 11:07:12 +0800
Message-Id: <20260727030712.1683158-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3274df73849ff8620dfcad063c6af17b10a36982.camel@gmail.com>
References: <3274df73849ff8620dfcad063c6af17b10a36982.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard,

Thanks for pointing this out.

After re-checking the old code, I don't think I can honestly attribute
the KMSAN report to one specific assignment.

The old code did have a few patterns that are undesirable for a
tagged-union state machine:
- in-place downgrades such as off_cnt = 0;
- manually assembled temporaries such as resolved in
  record_load_store_access().

However, I could not prove a concrete source-to-sink path from one of
those assignments to the `m |= a.mask` read in `__arg_track_join()`.

In particular:
- the off_cnt = 0 downgrades operate on states that are still
  interpreted as frame-based states in source-level logic, so their
  causal link to the later .mask read is not proven;
- the local resolved temporary is indeed only partially materialized,
  but it does not flow into `__arg_track_join()`.

So I think the code change is still reasonable as a state-construction
normalization for arg_track, but the original changelog overstated the
proven root-cause mechanism.

I've respun the patch as v2, reworded the commit message to describe
this as normalizing construction of the tagged-union state, and added
the Reported-by tag requested by syzbot.

Thanks,
Tao
