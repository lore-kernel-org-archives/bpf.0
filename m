Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960542F8E8A;
	Mon,  1 Jun 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341578; cv=none; b=gtEqKLlMBvEGtvapWIYzDTXJ7uXV/sBaHAQJQF8rva4HGa5IWLI6ZKe5YjReiBCHnUGGBNghJI8slCz8bsrUT6OkFjvP3STPgnyzLYZm2OcpcLYAKwhCFbT0M80sMeDTDt+Lmb9h/krzCiRNbNUQZsP/c8nv8zDIC7lE/KGXoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341578; c=relaxed/simple;
	bh=uinxhVCiWaNxtfJ84cfo2KQVlDViwZN95DIUpX26/RQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ijuUS3MXGEqS85Yi2w8K/ReDCnENsQ4J0VWsaWknA9DZUgNUO8RHGMY/1f99ZQm9giDZfDmxCN0wWa+C+RS46oJMj99CZnU89uVR8ahvz+c5Nigevfc89PdgKDMdlYOENIdPB5c83C5zMOXBClQTVz9OymMvkOaaJcFQTgq0htM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRh49ZuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRh49ZuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D271F00893;
	Mon,  1 Jun 2026 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341577;
	bh=uinxhVCiWaNxtfJ84cfo2KQVlDViwZN95DIUpX26/RQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VRh49ZuIYBKAi1bI1JQ8om7XMrQKkOzlZq8opGXD8itlEri7Aq7IK6JNiwYd4gf6T
	 ywIBfdRT5Qy+2DoM3EJxMPtsSEVYENTGliACYsDZrE7SbhA8L0F5YnE1FIUyboWU0f
	 97rQzg0Dk2tI/ZtUQz2HEUGZ00ERpWGoXksmIHHzLH7jGhhc25tj9MnCbqJU8snLsH
	 dyAmAdG6zFLjbfNxii5/kEVuZ7HhTARTMEg5aF1ztLZjS6Xg30q0v0vXg3o8TsjdZO
	 WMQiiDqW8/6SzBDUIx2fg8O6C2Xagd3VRu5YRyr8ZeaR6WgDlYXQMLdex60JWk3vBD
	 MaDGOqkuq3slA==
Date: Mon, 01 Jun 2026 09:19:36 -1000
Message-ID: <9e7dd118c7f0af2fc6de3c9f5c7493f6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating arena pages
In-Reply-To: <20260601185802.B22171F00893@smtp.kernel.org>
References: <20260601183728.1800490-1-tj@kernel.org>
 <20260601185802.B22171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

> [Critical] Replacing the populated scratch page PTE with a newly allocated
> page lacks a TLB flush on architectures where flush_tlb_before_set() is a
> no-op, causing silent data corruption.

By design. A scratch PTE only exists after a program has malfunctioned, and
the contract is just that the kernel does not die. Reading the scratch page
or the new page is equally fine.

> [High] Calling pte_page(old) without checking pte_present(old) can cause an
> invalid pointer dereference or kernel panic.

Same invariant the existing arena code relies on: these init_mm slots only
ever hold none or a present page, so pte_none() is enough.

> [High] Calling memory allocation and page table walking functions with
> interrupts disabled [...]

Pre-existing and unchanged here. Page tables are pre-populated, so
apply_to_page_range() does not allocate.

Thanks.
--
tejun
