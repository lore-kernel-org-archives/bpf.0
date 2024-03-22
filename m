Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71110F2
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071606; cv=none; b=rnZJDw4C/GVWk9wZW8l5zIsPiSzB4wCqYItTzN8x4503GYrxKxWGMg63HErceWMwhlC1ZsZ/dDYH43+fcmatWQ7KT9+8tC2rdlNtcwVm/ZKEWDVpBHO0ahh9BcjySKIvtys8i1gTN7GLnF7tTD/ML65XgSvwfv7ldC6UOqeLCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071606; c=relaxed/simple;
	bh=FSw3je7gaoFVnx+4DXXiieRmGA2ZMVa24Naitm+peao=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=ODfGQVpLLopKkSPds9fSPFhaB2vjbn9sdZ3l6hcMSOVhl4nd05Ou+ds6tbHJK7AGZmnW2MrpZ9rhZRumLHI0Dh2TJ27I6LL5BVGZRDwBP+bDH9DpVmPTxVlbcCXTvL5uCGqza1Q0dgupQl67rKY6CJSYLFz6sNKepUePuwaIk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PECmN9yZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PECmN9yZ"
Message-ID: <0edaead1-b20b-4222-9ed5-4347efcebbc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711071600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IBq5836/mNksjwZnEwNG8ApcvfYSLR1dBN58rdXkk8A=;
	b=PECmN9yZbBuAfHVOA+DvySPZtJgXsWaoo1ztmSKRq0tm8cENUU9N2oCUQA0U44KwpEiZol
	mP2FaJ5cEOxibS4t3XcKpb7VjWarq6zTWT3gulSoE/OzsaITi8PMr0QMrQRNmQMWYNv7EL
	oAYnjMlEVg6D36lcbpBDtgyvJwVwxck=
Date: Thu, 21 Mar 2024 18:39:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: BUG? flaky "migrate_reuseport/IPv4 TCP_NEW_SYN_RECV
 reqsk_timer_handler" test
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Kuniyuki,

The bpf CI has recently hit failure in the "migrate_reuseport/IPv4 
TCP_NEW_SYN_RECV" test. It does not always fail but becomes more flaky recently:
https://github.com/kernel-patches/bpf/actions/runs/8354884067/job/22869153115

It could be due to some slowness in the bpf CI environment but failing because 
of environment slowness is still not expected.

I took a very quick look. It seems like the test depends on the firing of the 
timer's handler "reqsk_timer_handler()", so there is a sleep(1) in the test.
May be the timer fired slower and the test failed? If that is the case, it may 
help to directly trace the reqsk_timer_handler() and wait for enough time to 
ensure it is called.

This test has been temporarily disabled for now 
(https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST). 
Once you have a fix, we can re-enable it again to ensure this migrate feature 
will not regress.

Thanks,
Martin
