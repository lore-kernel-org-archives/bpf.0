Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F6271A71;
	Wed, 27 May 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893795; cv=none; b=F6ZR6YF+RYuD7rHcm2M2EnSopYDXCD1W0jzc32x+KzTibHaU/2RxNoas5Gz/LRS4pU5OfbSp5zc/00nRtlljr1z6DKp4OuAdxKrj1olmC9uVBti7KEyQa8M7Zl1mZ7Koqq0k/dZSAkbXtR25CGpvXIN6dlWv/rZZO0AAmIQfHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893795; c=relaxed/simple;
	bh=1TmkfWrvfjU9Oexaw3JXK8IYB0E5N2bdveGsvKTozeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZglfYviZxyC+CSH+PyD/zAzwk+P3pklD39VzA1hAnwzZt7Yc1/TTad27XT51FfGtX2VyYM0AxKI5kj0uMXb9VuhrQyp9ysAEq6v4t24NJXFShYwmRb84SfxOGqv61ca+CQBqJF1CF2oUg5WrKyelnYHG3e+RmScx9E5tswhLKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZNjAv0Ci; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZNjAv0Ci"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 400cf3418;
	Wed, 27 May 2026 22:51:11 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: emil@etsalapatis.com,
	martin.lau@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH 1/2] bpf: cgroup: fix sysctl new value replacement
Date: Wed, 27 May 2026 22:51:12 +0800
Message-Id: <20260527145112.1858843-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DISYF7LAA8C0.55I0KJ1R3Z2L@etsalapatis.com>
References: <DISYF7LAA8C0.55I0KJ1R3Z2L@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e69eb0a5e03a2kunm14ff3b834476a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0xPVhgfQkkeSkhIGRpJQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ZNjAv0Ci1/5T4uoIHBFau0iT48dVS9lgTsHvs6chsGba0RJWa/kRnH64GpieiY2On9Mqff9cyWoH07AF/A2nOWTYI+g4AKjEMc2gyt2+reuoQFKQoiPAl1inQ7gt7LFv+0ZqXeQKXnHjwqoP1bZ0bDreD5mwxYaVO8/NWUu/yqQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=XsQnUDGkg2Cukaht9mz+3Qf1Ty2QVkmow43B0QE7vzw=;
	h=date:mime-version:subject:message-id:from;

Hi Emil,

On Wed, May 27, 2026 at 6:16 AM, Emil Tsalapatis wrote:
> The bot makes a similar point, but can you swap the order of the
> patches? Patch 1/2 makes the invalid kfree more easily triggerable,
> and patch 2/2 fixes it. Swapping them avoids the issue entirely.

Thanks for the review.

I will address these points in the v2 patch series by taking the following
actions:
1. Reorder the original patch series.
2. Fix the potential out-of-bounds reads reported by the Sashiko AI review
   in an additional third patch.

I will send out the v2 series soon.

Best regards,
Dawei
