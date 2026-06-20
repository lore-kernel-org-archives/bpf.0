Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854F29D26E
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988426; cv=none; b=fGCKiICOuzrzN9RJBfx1L0AMQiUDtHax2Ds3IZf+at5X5tK/sYZIuqgoQ3fKs7tmcx5RGS1bht+9OX/mIAqH74LhoJ5k55YJg6VXU1N3sq6oo2aFCTEvh2qJhZvXKKFdXiK5dssDpso1J90R7hkgE+Q9sQsOFf+n7ilgCkJJxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988426; c=relaxed/simple;
	bh=CW0DzyL6+BzVCQ8CAhVTOCizMBQccK9EGBg18mcZV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnleBDwn4RJwmToFt3qHxtpRFbz+qzxSXbym9/uy6tfgeqHC5HVcwt7dIVHjgUVQ5TuTRP9nyP8r+lJnki5kDhOT5YqOTxUozrUTfgT43Zt6Ve7xcE7ik6b8+Xf4q//dz18kMHrg8RUHfikUnVkmrEslZwWnjf1VWFeCr7v5JAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p5POtbHU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p5POtbHU"
Message-ID: <45887d00-9495-4069-9c97-34498cc90e88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781988422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW0DzyL6+BzVCQ8CAhVTOCizMBQccK9EGBg18mcZV38=;
	b=p5POtbHUeY6DxFgKvdsnP5sT7VgeZqXe46lj3MRPjFWAU2TzqY8HUAHpdn2qeY3ChsENJG
	7/mj7aHmCdOftcUIa07wTg2WTGbL6MDVDCQ0Hy3z2+6oKRDDFViLda2MsNOga/Qg117Pi3
	nsr31R/QxKx1XiEyYqQCqDZtEM75ics=
Date: Sat, 20 Jun 2026 13:46:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test cgroup link replace with
 BPF_F_PREORDER
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com
References: <20260619063520.2690547-1-ameryhung@gmail.com>
 <20260619063520.2690547-3-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260619063520.2690547-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/18/26 11:35 PM, Amery Hung wrote:
> Add a cgroup_preorder case that attaches a normal and a BPF_F_PREORDER
> program to a cgroup (effective order [2, 1]), then replaces the normal
> link's program via bpf_link_update() and checks the effective order
> becomes [2, 3] — i.e. only the non-preorder slot changes. Without the
> replace_effective_prog() fix the array is corrupted and the order is
> wrong.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

