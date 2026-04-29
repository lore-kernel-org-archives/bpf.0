Received: from smtp.dnamail.fi (sender001.dnamail.fi [83.102.40.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187B335081
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.40.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498867; cv=none; b=KNKfF8BI/VKOfjwI7+uFWu78NXemLDf4y+nhJyYGr2AI50tAHHFijrdcTwiffw9kHAdb27nh9FJK3FT2qecWUpg8LDbIDbc6zd+Votz0jIm2vbFOQfma+QVovAoF+grIuM+O4ha1lOPeTWQOzWnLVFdflU5jaOu5RUM9/uGIlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498867; c=relaxed/simple;
	bh=HI1HL9u/AmZbm/qj5TsTwFmPAq31fzrorkhLCWJK3ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA904n0aM0p55I94nuavcR+UTXHBHQgT1AR6xu+ZOKu7RQgtsEy7frS0b/kSMJX4reO8sEODOh2qtRyXIEO+tgLpuSd8SLXR8Q9cfxXiOr5ZlYSbgRTyu5FUdUMkA6Hg47mFfi0/dyK26A126xKHN/dxvATNr0kPkex3tHyCoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b=MWpn1riV; arc=none smtp.client-ip=83.102.40.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b="MWpn1riV"
Received: from localhost (localhost [127.0.0.1])
	by smtp.dnamail.fi (Postfix) with ESMTP id 340B52119C3E;
	Thu, 30 Apr 2026 00:33:47 +0300 (EEST)
X-Virus-Scanned: X-Virus-Scanned: amavis at smtp.dnamail.fi
Received: from smtp.dnamail.fi ([83.102.40.178])
 by localhost (dmail-psmtp01.s.dnaip.fi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Bo2_1vCe3QyW; Thu, 30 Apr 2026 00:33:46 +0300 (EEST)
Received: from [192.168.101.100] (81-175-148-178.bb.dnainternet.fi [81.175.148.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: oak@dnamail.internal)
	by smtp.dnamail.fi (Postfix) with ESMTPSA id C25E221148BE;
	Thu, 30 Apr 2026 00:33:45 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dnamail.fi C25E221148BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helsinkinet.fi;
	s=2025-03; t=1777498426;
	bh=YKwrYGQaKE7iV1XjT+kr0O9MjSYGoCMPKi8aNhQyomQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MWpn1riVkAoKQMa/PCEY1mB29JEeWErTaX+4lJHzDuNe74GaPz1hCuYiQLxiQOre/
	 B7D+bmzzoUFfILsjWkz0OuLjGcdqUd1QqRAUEksMLU6OMft7IkxfFF2LcWo82LYARK
	 2be7Nt+JMQLAzX+eHvb9zgJcZTpFzz1m6u9poL8zA3l8ZRHdwDX6o5mzwX65mLhxXi
	 qknZSq7Iu+4R+yNQ/6lZu8Tm/5bJkRC3k0b5OEZ44Ev0szan8MtuKv2VmBvTU+3zYL
	 5xgrOkZGTG4eGbAEhHpimalo+Y2FLv720fCZuipsa8Zftrqm93OPtMhHpQOhyI0oUq
	 /ncvqnmUwc5EA==
Message-ID: <b7af68ae-17fa-4cbf-939c-84400727a141@helsinkinet.fi>
Date: Thu, 30 Apr 2026 00:33:45 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>, daniel@0x0f.com
Cc: linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org
References: <20260429124046.3480827-1-visitorckw@gmail.com>
 <CAFr9PXm0qxeSYq42MEOARKsmOT-hRLbT4UpchkwuSOMYKYzfOw@mail.gmail.com>
Content-Language: en-US
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <CAFr9PXm0qxeSYq42MEOARKsmOT-hRLbT4UpchkwuSOMYKYzfOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/29/26 4:51 PM, Daniel Palmer wrote:
> On Wed, 29 Apr 2026 at 21:41, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>> Add a BPF JIT compiler for the m68k architecture.
>>
>> The JIT generates m68k machine code targeting m68020+ processors. It
>> currently excludes 68000/68010 and coldfire processors, as it relies on
>> 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
>>
>> Tested with the test_bpf.ko:
>> test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
>> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> 
> Cool! Which CPUs did you test on? I guess 040 that is in QEMU?
> I'll check on real 030, 040 and 060 machines a bit later.
Before real 030 HW testing, I would recommend checking first that things 
work well with Hatari emulator.  Unlike Qemu, it emulates also CPU 
caches, so it can find issues related to that, and it provides much 
easier debugging and (semi-cycle-accurate) profiling support.

Instructions for doing that are in the Hatari repo (GitHub mirror):
https://github.com/hatari/hatari/blob/main/doc/m68k-linux.txt

New enough Hatari release is in Fedora, Ubuntu 26.04, Debian testing...

(If you have any questions, you can mail me directly.)


	- Eero

PS. Another alternative for semi-cycle-accurate 030/cache/MMU emulation 
would be WinUAE Amiga emulator (which is upstream for the Hatari CPU 
core emulation).  I don't have any instructions for that though.

PPS. Hatari emulator has been used e.g. to profile & optimize ScummVM 
and its game engines enough that upstream ScummVM releases include Atari 
version which works to some extent even on original 030 machines (and 
naturally much better on accelerated machines):
	https://www.atari-forum.com/viewtopic.php?t=42429

