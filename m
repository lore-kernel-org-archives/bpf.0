Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA043E9D6
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931980; cv=none; b=d6R4WgL6c/sYoHq8veWxOjI1S4LPQFscF6RL4bSEHgOHKSqnE2T+NS78mg8hhit31d8pOy5YjzZUXRK9QjLEg6Umd1Iq2HFhvnPr0m0yRA85o1PIcGpFar4YNGqz9ACVKC7UQ3sFYRuSJDVwGUE1HIgGkMIifeItwSbHex6IdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931980; c=relaxed/simple;
	bh=bdjbEHEW+oM1TOrOS/ZNpJXePQWo6lFXurp2ujy8R4M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=s+K7HCtYxfnLMI+k/metG+G5/KWXYP/DGho/HpeDU0jAiLfmo6Q1wVDKlQh+6AO+VqyZtfX4oMJyQxSRYxgI3FiGpVrhg4LfpYgUljlTf9rkHDupjvQTg+HRNObZ5zkQ3SZNVXIIDTwYrJoNv+ncEvht1ZRKxhJ6y+DiehKiVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcduDx3X; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcduDx3X"
Message-ID: <8553c4ab-9b42-46a8-9187-38ba4f63fff0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768931976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkZPUKuWKyT9sbwHR/Y7BPassXhhlpT5X3651dWwMzc=;
	b=gcduDx3XC94wozmK8ScyzrL18a+diCglVHRJRVwpdA3TvZK1BUvPixCHqvdEiXWEsIppiV
	9uOv38LmUeJqJXDr1PHl9x1Sed8be10Oxhc7r0x676iakpnu175CSWt4Ywf7hbDvUBJwVT
	J0QsqKZ0HyP3jO/Njo2EHGjwGo8Xsag=
Date: Tue, 20 Jan 2026 09:59:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [BPF CI] OOMs on s390x runners
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Ilya,

The BPF selftests regularly fail on s390x runners with OOMs.

The s390x hosts that I've been maintaining have 16G of memory, hosting
2 runners each. VMs (qemu instances) running the tests currently get
5G of memory each.

I noticed that the s390x runners didn't have swap set up, so I added
an ansible config to set up a swapfile. This seems to have helped with
OOM failures.

https://github.com/libbpf/ci/commit/8767dc05ab84c88da198af3c651511e731ddbac7

I spot checked a couple of recent failures, and all of them happened
on the "ebpf1-worker-*" runners that you've been maintaining IIRC.
Here is a couple of examples:
  - https://github.com/kernel-patches/bpf/actions/runs/21178791628/job/60916006746
  - https://github.com/kernel-patches/bpf/actions/runs/21163448380/job/60863171062
  - https://github.com/kernel-patches/bpf/actions/runs/21157785072/job/60846570064

Could you please re-provision the hosts with the swap setup?
Let's see if that helps.

Thanks!
