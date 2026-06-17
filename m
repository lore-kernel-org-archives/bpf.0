Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB931BCAE
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686286; cv=none; b=K442HPsWfuSfcHRsLs8vfc8dvZZr/MMcYanlzr1n/oTN1mFPhnURJQ/ACoBnHHquQU77bYPW7IuRi9JM6Wx9pTVqmKo3dv2d8ozaEiS/lbzIwfrNleW2G8higlcpT5dJXwmb/QwhPry3yD/2x9plNLcMhugrsBzG1w4bXEiugEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686286; c=relaxed/simple;
	bh=7jOQwyTAzKJwsqIrwI4rqGiIXyGQCVHuD/4hW50+EoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsYv0D8GtG8qyIu0kpic5NUYrrrfmQMov4+tSw1d94o61PhoygA4jC+qp55uqktism5TakKnkaSUpVYwFBjJYoVAJrZNQboiiuQcVPd44W0/F5IAGnDJbCLG73Bw2GljecTSQsqxXPlz8+4w/uudNzwNUuLO+H/ovEldOvN1JFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eyTjndhm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eyTjndhm"
Message-ID: <1c178c2f-358c-4933-b74e-36522f699f71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781686282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU5qvsh3dMUY4+ATFzYh4gkQERaGRrV6gNprJHKVvNE=;
	b=eyTjndhmJusNq1s7n6ec7rr+66OBzuuVglHQfJDchQSE9hWPLcVwz0XAEhfM9TlHCs/DGu
	akC+RYMZX8y06LnEIpLPHY9aGrtINWawFAeP8qheeLfm9yh5W06aUkYU80ZGInxqQpMCW0
	W0upzlr/mXGA/YUaBN9JU3vMdI1A/Fs=
Date: Wed, 17 Jun 2026 16:51:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] BPF changes for 7.2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Yiming Qian <yimingqian591@gmail.com>,
 Zhang Cen <rollkingzzc@gmail.com>, Han Guidong <2045gemini@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org
References: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
 <CAHk-=wjAVP3uu1inFqxeGmk5bTJqm204kxcWu8zzDGFNOh=Q7A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAHk-=wjAVP3uu1inFqxeGmk5bTJqm204kxcWu8zzDGFNOh=Q7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/17/26 4:37 PM, Linus Torvalds wrote:
> On Mon, 15 Jun 2026 at 19:09, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> There are two conflicts:
> Actually, since I ended up doing things a bit out of order and did the
> networking pull first, there were three conflicts, and while the two
> you mentioned were trivial, the one to net/core/filter.c was a bit
> different. Both networking and bpf had done "make sure to preserve the
> sg.copy" bits, but done it quite differently.
>
> And I think bpf did some things better, and the networking tree did
> other things better, so my resolution is actually a mix of the two.
>
> bpf had nicely named helper functions.
>
> And the networking version used __assign_bit() instead of duplicating that
>
>      if (set)
>            set_bit
>      else
>            clear_bit
>
> pattern.
>
> So my resolution is to take a bit from column A, and a bit from column B.
>
> And the networking tree had a case of clearing the sg.copy fields (in
> bpf_msg_pull_data()) that the bpf tree didn't have at all - but I took
> the nicer helper function from the bpf side.
>
> Did I get everything right? It _looks_ right to me, and better than
> either side on their own. But mistakes happen. Please check out my
> resolution and send me fixes from whatever I may have messed up.
>
> It doesn't help that I did this on my laptop while traveling - I hate
> not having my big monitors and better test build environment, but I
> tried to be careful, and it builds for me in my limited test
> environment.
>
> Please give it a good once-over - I've cc'd everybody involved on both
> sides of the conflicting changes.
>
>                  Linus


Thanks, Linus. I was just trying to figure out how to send a patch to
avoid this merge conflict.

The resolution looks correct to me.
One tiny thing: the call to sk_msg_set_elem_copy() in sk_msg_sg_move() has a
trailing tab — it doesn't matter at all, and I'll clean it up next time I
touch that code.

Sorry for the inconvenience.

