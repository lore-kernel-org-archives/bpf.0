Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964E369D5D;
	Wed,  1 Jul 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924096; cv=none; b=YXYv/G+t4NhlYFB2WSZOdhNRN7cpzBpZsCLwO0KnuBdCtFGTM2cPTVv9yySs5D7SSq5jPqQjDx4YdCDQGZHJMxdX7nNkQXlv5AystnIXAeq3wz3vE/g/B+aWucuc6OPPoZVsTfPnP/vFJyALNXqh/fnuHQ95xNOXPNKBzjk2U6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924096; c=relaxed/simple;
	bh=/Aia+l3JXNvl5mFhzZ1SjTrPVeFdzrMTW/SKmTBkbvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYbq3WwBLvqv+B8w8sTz/2TOt9Gtn78gGtWr7n6pslUipIy7wI+Z4/MqdYQM+C9/B0IRUX4zWrQDzFy/2CY8TY28XEJRgz1uspt5nETXhCKHUEzyOq0Bsa597c6baD0VF7A67Cnui1WQT+/j8813jY6MuoO585CUmeYxg3O2xBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RGnGwwuf; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RGnGwwuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1782924086; bh=/Aia+l3JXNvl5mFhzZ1SjTrPVeFdzrMTW/SKmTBkbvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGnGwwufgkk4TFIVBVD7JoL1zr3AjxFNTZMMfrGfiVuL/mYEVDVnHVEeUORBYQzs2
	 RdWHW65TvTEu5qk4GJnQUMfu6gDTzJAeoeZ1FX/E4p+lHZHon0HTPHctFGUOraj6YF
	 4OAln/4MpChArF9t8Tdlj6d4gbiqnvjGIZyC5UbHeu+OFZsp/DbZEm6bDb8vmuXA1n
	 BU6xYaYfk+v8WZyHA1DYL15JN/S9Si0/YdgBZDjCtxCuq1tZenemQk788eWOXCfVZN
	 kAKdgmM392wJg+G0VNugV/F/zVhXLGmDUcm3WXw2pGB+4Et9cvO/sE8e1CphN0XGHJ
	 bgB8j7nGl7a6g==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id DDA2341567; Wed, 01 Jul 2026 17:41:26 +0100 (BST)
Date: Wed, 1 Jul 2026 17:41:26 +0100
From: Sean Young <sean@mess.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf/selftests: remove lirc test
Message-ID: <akVDNsud-Z9DXmem@extorris.mess.org>
References: <20260605-remove-lirc-test-v1-1-ee3f1ea5f3ae@bootlin.com>
 <CAADnVQJWBN2wohM8PM4rNGqtgGWQH__sgjrUv7h8SmWE7Px0FA@mail.gmail.com>
 <aiLpfQze1msH8ubd@extorris.mess.org>
 <8cc9e60a-4935-437b-ae79-36658223defa@bootlin.com>
 <8419863d-1e0f-4343-acca-ad75c66092cf@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8419863d-1e0f-4343-acca-ad75c66092cf@bootlin.com>

Hi Bastien,

On Wed, Jul 01, 2026 at 05:26:20PM +0200, Bastien Curutchet wrote:
> On 6/8/26 2:51 PM, Bastien Curutchet wrote:
> > On 6/5/26 5:21 PM, Sean Young wrote:
> > > On Fri, Jun 05, 2026 at 06:39:51AM -0700, Alexei Starovoitov wrote:
> > > > On Fri, Jun 5, 2026 at 12:58 AM Bastien Curutchet (eBPF Foundation)
> > > > <bastien.curutchet@bootlin.com> wrote:
> > > > > 
> > > > > test_lirc_mode.sh fails with the following when run from the vmtest VM:
> > > > > root@(none):/root/bpf# ./test_lirc_mode2.sh
> > > > > Failed to read decoded IR: Resource temporarily unavailable
> > > > > FAIL: lirc_mode2
> > > > > 
> > > > > As part of the ongoing effort to get rid of any standalone test, this
> > > > > script should either be fixed and converted to test_progs or removed.
> > > > > 
> > > > > Remove it.
> > > > 
> > > > cc Sean
> > > 
> > > I've sent a fix to for the test in a separate email.
> > > 
> > > This regressed a long time ago; is anyone running these tests? There is
> > > not much point to selftests if they're not run by anyone. I should add
> > > them to linux-media CI, but is anyone in bpf running them?
> > > 
> > > I am not familiar with test_progs, what's that?
> > > 
> > test_progs is the selftest's application run by the BPF CI for every
> > patch series sent to bpf@vger.kernel.org (or PR done to the BPF github).
> > It's made out of the C files located in tools/testing/selftests/bpf/
> > prog_tests/.
> > 
> > The shell scripts under tools/testing/selftests/bpf aren't run
> > automatically anywhere (to my knowledge at least). The goal of the 'on-
> > going effort' I mentioned is to get rid of these scripts by either
> > integrating them to the 'test_progs infra' or removing them.
> > 
> > If you're going to add this script to the linux-media CI, maybe we could
> > remove it from here ?
> > 
> > 
> Gentle ping: would it be OK for you if we remove the test from here ? I've
> seen your fix, the bug was introduced in 5.17, which means no one had run it
> for 4 years. Given that, I'm not sure it's worth the effort of porting it to
> the test_progs infra.

So the test is useful and should be run regularly. It should be ported to
test_progs or moved to media-ci. I haven't decided yet which way I want to
go. I'm just a bit busy right now, I'll get round to it soon.

Thanks,

Sean 
