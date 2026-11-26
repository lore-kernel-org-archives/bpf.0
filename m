Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692726;
	b=Mgue4jJvgPGwg9TgWfdDsHJUGijJevoz0/g2W1Z5+momyoA9oggF0lkG83Xt04W66uWy
	 qn8OQMyEG0u1tJs/P3iQUbBePPyteHXB/gP48W9IpeyFUckNkiaGPv3Q+WkxFShSOXn0n
	 YL6fOIQ8054rqZtfuGRjmIz6mUrU+W4QFv8KgZsTE0LlDuSiJjjyJG0IYTNMn7rgXw/gF
	 uS+2MpQv0qhD2LKDupdwBLCTNDBTn0Nkgd4zpdfO4EipoPJG6PfuBXFS2W8kAp4D2jaLe
	 67MdCzKW8mUBfVIMhwQJOt0QK0kZCz3PSGUUZaU1dCIkhlpqLA5ZFb3z5UUiTvQZLsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692726;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	b=MUekrT6NNd9dCHf758ua0R5YocQUGiwRnF7+5lJvJ0cLxlFQJyPZNkw/Wf9Hjf/KMeFl
	 ycfJj4Ocy4eY9FMOdY442xdVzaS9WkN2w4US0hx7qPUIA7JPFzIHjCQ0Xq69caZNu1S9C
	 ORNjJ4+UCpZSpnFszKLXQWsM0q7n7TzV6Nvi22s3ph9ILPnLacoLAz+UiUmnJ0NnVPD4Q
	 Uy8Z1x9v6FpUzGQnGzVr3EfjGYUM2f/tvlu2E1bV50Hw57VMSBVi5sXHKau9GaGjUhtC6
	 zXD7Vs7P7+YLAKABYqJzDpx8XOZL9MZnwRJYnfVHk/i2AZW/TTq5Ll/ZW3coC6QP/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCF3O2rH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40389606A339;
	Thu, 26 Nov 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCF3O2rH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A6F1F000E1;
	Thu, 26 Nov 2026 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692725;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bCF3O2rHVArgzNDaB9ZI0+FPp4s3edTpQ/suSEw2KddFtg5maQ562R+VuAJe0FDIy
	 SCMS8gQqBGSJ8SHhQ9Y0QuVJ0fHVYxbUTdIW9CMx7pWcBUZaak9d5ihiwPYI92PkPX
	 nJ4FeJdO3pGqkFcEHFsI5N8KqB/KNnx39aHHba1M7pTUP0XZShjHwxnAGjOryzjNP6
	 mm0drSrUpiRb6C830J5LR8dFegyjJCq9MoYFh3a/5I9q3HWdyZlidVpaCmkFwvLSEE
	 D2XwM4T/i0EXAe/U5YYTwyv4ANk0LovbvycW9ZMCQb6KJWU6eFtELnDoDxSZdlcPXa
	 ZmlwKWqNg5hEQ==
Date: Thu, 26 Nov 2026 01:32:04 -1000
Message-ID: <dfdc0cc34a00bb96739307d784113485@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shaojie Sun <sunshaojie@kylinos.cn>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Document clang requirement for arena schedulers
In-Reply-To: <20261126055301.652002-1-sunshaojie@kylinos.cn>
References: <20261126055301.652002-1-sunshaojie@kylinos.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.5.

Thanks.

--
tejun
