Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C338B9BA
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055253; cv=none; b=gXyfxpEVzTN3GZ7W2Q0HzSXZQICXt+h4DlQvdaidCgyoSdA1IBv9i+TcnxV/tETiy1ITtul0w1XXk0tS8bFwJagfPPI37SQMQhPo6qxtpzWI3stH0JrRsQWX+XZ7mwS5SVpaccApdqU48KvDvdkU4oA1iKq+ePTqBYFH/vrwTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055253; c=relaxed/simple;
	bh=raP/Dc1X4BOR8E6AwRtW38Yx3rQpJVVhcyB5kGKxdq0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nPdcdJT5IJ/uaxVBLy0gEi9uJ5E6oEKqeX4ijlasWi/mQ03nbxSiN6nJmQV4VtQ5qUgOS+zLuKIixa8J9di+Itab7+u7mavcqH7QBC+alSkiZK1FHOegbrW1CQJbl+xPCM46R3DS6gY7Ubcqq2IJqMdz1rHDuTbMr1oyY9V3eCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6s0YBKt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6s0YBKt"
Message-ID: <04fd4fdb-ac74-4d9d-942a-10c3b1d9d965@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770055249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=raP/Dc1X4BOR8E6AwRtW38Yx3rQpJVVhcyB5kGKxdq0=;
	b=l6s0YBKt/MQzMPS0cjpg7Cjd8330bIr61GLGJRTK9iJVeoVq2Zo09xaRwBglNEg23VgK11
	tnHJFvMPDX64BMtU+azeYbuKPTXl3ScYX5Wn+hEei2aN7XAOuWX6q8cBWVyyWHctY2xXGD
	i5xnkVkXwuXbuwA3OARfGizuuAtIALY=
Date: Mon, 2 Feb 2026 10:00:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Cc: Kernel Team <kernel-team@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [LSF/MM/BPF TOPIC] BPF CI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello everyone.

I'd like to suggest a session, where I'll give a brief update on
changes in BPF CI over the past year and have an opportunity to get
feedback from the developers.

We can also touch on recently integrated automated AI code reviews on
BPF list, because it's interesting and exciting. However if we choose
to do so, in this session I'd try to focus on user/developer experience
and CI plumbing side of it.

Thank you!
