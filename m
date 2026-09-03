Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652B46C4CD;
	Thu,  3 Sep 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443102; cv=none; b=UJE5mzX3WCyJV3Dtrd092l1y1Tb+LaOaYYEIE6nwDvY50q84icwsWOCRt2yf/Gnu5D9LS2NMkpPaps5GqjVEVF7d2DO/lnFi9+aTGpEi51EQYIqm9JzZycHLkWwSHk4Iy92E1wq4JEemdktJskn421NQENJcYLMoGjsoJhc9p/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443102; c=relaxed/simple;
	bh=OcBRudey4HYib83xRogPjVJ0CVDoo+6pQ5k5qrOcagQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvCiTC5SClZtSimk9EQi5IQB8eiZkNiwqNCVtpF08mtzaDIH9QQO16SimcsUZLs452n0S6CIaPaFpqEh/VxJSmhYKES8zmi1aS0lO4pc13cI8Rj/eq1k4Pjs2p66GAu5p2runoS4bTc1FtpEjzDLPUB6z4CzA+fvezx972r7kBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OJpa/M8F; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OJpa/M8F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2nyRUfrntiH8DpeqrJpnUPG2G5Js5y3XiuDTkGJaHK8=; b=OJpa/M8F7ysF1nzg8fcB1UB0tL
	S6nTbz2pb/9pMizMIvPQ7E3Qmhj/akG00SWUoNtZDtR410iU2tdpbjZq6D2WBL9zxA/IqT1hvEuFg
	2QM93r1HJ2z7w3VmQD+hsdcuLdyfMDOFmfX+Tpw/VRkhbVbJP9a6WNoo5azw2eNzloO0KSD9S2Zm8
	jjQeGWQu1P2EOUkux0tsesT6zjKVcBym8kyZmbTtBoqU01jMvD/N+6widsS7+z7NF4YTPjfvavqt8
	qfzpSmh+aQvp7DHtkwO0veosDc7BpzsrWyeoZDsfM7BCh1R4WYHFl5tnnHBu3DROYxOM3K7UMClhh
	t5flcvZw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x27k4-000GqA-2u;
	Thu, 03 Sep 2026 15:44:36 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x27k3-000Mxd-30;
	Thu, 03 Sep 2026 15:44:35 +0200
Message-ID: <10886894-081b-499f-abce-fca62b120615@iogearbox.net>
Date: Thu, 3 Sep 2026 15:44:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT
 processes
To: Bochao Cao <bochaolucky@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
 <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net>
 <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com>
 <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com>
 <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
 <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com>
 <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
 <CAHKNYVXFB5aFBNU5-__TsVNNX2ket7TO1EB-HcX1FgJhbKeVCw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHKNYVXFB5aFBNU5-__TsVNNX2ket7TO1EB-HcX1FgJhbKeVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28112/Thu Sep  3 08:22:22 2026)

On 9/3/26 10:10 AM, Bochao Cao wrote:
>   Thanks Daniel, Alexis, and Emil.
> 
>    Moving the test to tools/testing/selftests/drivers/net/hw/ appears to
>    require more than relocating the shell script. The xdp_features userspace
>    tool, BPF program, skeleton build rules, and test environment would also
>    need to be adapted to the net driver selftest framework.
> 
>    Would it be acceptable to take the process lifecycle fix as a v3 in its
>    current location, followed by a separate migration series?
> 
>    I would also be happy to work on the migration. If you would prefer to
>    see the migration before this fix is applied, I can prepare v3 as a
>    small series, keeping the framework migration and the process lifecycle
>    changes separate where practical.

No objections from my side to take the process lifecycle fix, I would however
suggest that this goes into net-next tree in this case: the BPF CI does not
depend on this script, and if we would merge it into bpf-next then you'd have
to wait for ~8 weeks before the trees sync during the merge window.. that way
via net-next you can continue with the migration and as next step cleanly/
conflict-free remove the test_xdp_features.sh script from BPF selftests and
adding it for net/driver HW selftests.
> Emil Tsalapatis <emil@etsalapatis.com> 于2026年9月2日周三 15:44写道：
> Emil Tsalapatis <emil@etsalapatis.com> 于2026年9月2日周三 15:44写道：
>>
>> On Fri Aug 28, 2026 at 5:32 AM EDT, Bochao Cao wrote:
>>>   Resending as plain text because my previous reply was rejected by the
>>> vger mailing lists. Sorry for the duplicate.
>>>   Thanks Daniel and Alexis.
>>>
>>>    Dropping the procps dependency is not the primary motivation for
>>>    this change. I agree that Debian can remove the dependency independently.
>>>    The issue addressed by this patch is process isolation in the standalone
>>>    test. The current readiness check may observe an unrelated
>>>    concurrent xdp_features process, while cleanup may terminate every
>>> xdp_features
>>>    process on the host. In addition, a DUT which exits before listening
>>> can leave the test waiting indefinitely.
>>>
>>>    Although this script is not currently run by the BPF CI, it remains
>>> useful  for testing real hardware,
>>>    so these process lifecycle issues can still  affect users running
>>> the test manually.
>>>
>>>    Would it be acceptable to fix these issues in the script's current location?
>>>    If the preferred direction is to move it under
>>> tools/testing/selftests/drivers/net/hw/,
>>>    should the move be submitted first, with this fix rebased on top?
>>>
>>>    I can send a v3 that drops the Debian Closes tag and focuses
>>>    the commit message solely on the process isolation, timeout,
>>>    and cleanup fixes once the preferred location is clear.
>>>
>>>    Thanks,
>>>    Bochao
>>
>> While I'd defer to Daniel and Alexis on this, imo we could merge the fix
>> as-is and move the file as a followup since the change is a net gain on
>> its own.
>>
>> Wherever we end up putting the file feel free to add:
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>>>
>>>
>>> Bochao Cao <bochaolucky@gmail.com> 于2026年8月28日周五 14:10写道：
>>>>
>>>>   Thanks Daniel and Alexis.
>>>>
>>>>    Dropping the procps dependency is not the primary motivation for
>>>>    this change. I agree that Debian can remove the dependency independently.
>>>>    The issue addressed by this patch is process isolation in the standalone
>>>>    test. The current readiness check may observe an unrelated
>>>>    concurrent xdp_features process, while cleanup may terminate every xdp_features
>>>>    process on the host. In addition, a DUT which exits before listening can leave the test waiting indefinitely.
>>>>
>>>>    Although this script is not currently run by the BPF CI, it remains useful  for testing real hardware,
>>>>    so these process lifecycle issues can still  affect users running the test manually.
>>>>
>>>>    Would it be acceptable to fix these issues in the script's current location?
>>>>    If the preferred direction is to move it under tools/testing/selftests/drivers/net/hw/,
>>>>    should the move be submitted first, with this fix rebased on top?
>>>>
>>>>    I can send a v3 that drops the Debian Closes tag and focuses
>>>>    the commit message solely on the process isolation, timeout,
>>>>    and cleanup fixes once the preferred location is clear.
>>>>
>>>>    Thanks,
>>>>    Bochao
>>>>
>>>> Bochao Cao <bochaolucky@gmail.com> 于2026年8月25日周二 21:01写道：
>>>>>
>>>>>    Thanks Daniel and Alexis.
>>>>>
>>>>>    Dropping the procps dependency is not the primary motivation for
>>>>>    this change. I agree that Debian can remove the dependency independently.
>>>>>    The issue addressed by this patch is process isolation in the standalone
>>>>>    test. The current readiness check may observe an unrelated
>>>>>    concurrent xdp_features process, while cleanup may terminate every xdp_features
>>>>>    process on the host. In addition, a DUT which exits before listening can leave the test waiting indefinitely.
>>>>>
>>>>>    Although this script is not currently run by the BPF CI, it remains useful  for testing real hardware,
>>>>>    so these process lifecycle issues can still  affect users running the test manually.
>>>>>
>>>>>    Would it be acceptable to fix these issues in the script's current location?
>>>>>    If the preferred direction is to move it under tools/testing/selftests/drivers/net/hw/,
>>>>>    should the move be submitted first, with this fix rebased on top?
>>>>>
>>>>>    I can send a v3 that drops the Debian Closes tag and focuses
>>>>>    the commit message solely on the process isolation, timeout,
>>>>>    and cleanup fixes once the preferred location is clear.
>>>>>
>>>>>    Thanks,
>>>>>    Bochao
>>>>>
>>>>> Alexis Lothoré <alexis.lothore@bootlin.com> 于2026年8月24日周一 22:49写道：
>>>>>>
>>>>>> Hi Daniel, thanks for the notification
>>>>>>
>>>>>> On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
>>>>>>> [ Trimming the excessive Cc list, and adding Alexis ]
>>>>>>>
>>>>>>> On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
>>>>>>>> From: Bochao Cao <bochaolucky@gmail.com>
>>>>>>>>
>>>>>>>> test_xdp_features.sh waits for any xdp_features listener to appear and
>>>>>>>> uses pidof during cleanup. A concurrent test can therefore make another
>>>>>>>> test proceed before its own DUT is ready, and cleanup kills every
>>>>>>>> xdp_features process on the host. The readiness loop also has no timeout,
>>>>>>>> so a DUT that exits before listening leaves the test hung indefinitely.
>>>>>>>>
>>>>>>>> Track one active DUT at a time, wait for ss to report that exact PID with
>>>>>>>> a bounded retry loop, and reap it after each test. Consult the shell job
>>>>>>>> table before signaling the DUT so a stale PID cannot target an unrelated
>>>>>>>> process. On failure, terminate the shell job with SIGKILL and reap it so
>>>>>>>> blocked I/O cannot hang cleanup. Install an EXIT trap and signal handlers
>>>>>>>> so failure paths also remove network setup.
>>>>>>>>
>>>>>>>> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool")
>>>>>>>> Closes: https://bugs.debian.org/1136522
>>>>>>>> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
>>>>>>>> ---
>>>>>>>> Tests:
>>>>>>>> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
>>>>>>>> - make -C tools/testing/selftests/bpf xdp_features
>>>>>>>> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
>>>>>>>> - verified cleanup terminates a blocked DUT without affecting an unrelated process
>>>>>>>> ---
>>>>>>>> Changes in v2:
>>>>>>>> - Clarify that avoiding name-wide process matching, rather than dropping a dependency, is the motivation.
>>>>>>>> - Track and reap one active DUT at a time instead of retaining historical PIDs.
>>>>>>>> - Address PID reuse by signaling only the current Bash job during cleanup.
>>>>>>>> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang wait indefinitely.
>>>>>>>> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com
>>>>>>>> ---
>>>>>>>>    tools/testing/selftests/bpf/test_xdp_features.sh | 82 ++++++++++++++++++------
>>>>>>>>    1 file changed, 62 insertions(+), 20 deletions(-)
>>>>>>>
>>>>>>> Sorry for the late reply. With regards to https://bugs.debian.org/1136522, src:linux deb
>>>>>>> does not have to depend on this at all, so the src:linux can just get rid of procps in
>>>>>>> any case if this is indeed the last dependency. I'm not seeing the test being run in our
>>>>>>> BPF CI. I've Cc'ed Alexis as he's in the process of migrating and/or removing tests from
>>>>>>> tools/testing/selftests/bpf/ depending on how they fit into test_progs framework. I'll
>>>>>>> let him comment if there is already work in progress. It feels like this script could be
>>>>>>> reworked into tools/testing/selftests/drivers/net/hw/ tests and removed altogether from
>>>>>>> the tools/testing/selftests/bpf/ dir.
>>>>>>
>>>>>> There has been an attempt to fully convert and get rid of
>>>>>> test_xdp_features.sh, but discussions around the corresponding series
>>>>>> highlighted the need for the script to remain available for testing on
>>>>>> real hardware.  Features covered by the test_xdp_features.sh that were
>>>>>> not covered yet by test_progs have been added to test_progs (in
>>>>>> xdp_cpumap_attach), see [1]. So there's currently no active effort on
>>>>>> this one on my side.
>>>>>>
>>>>>> Alexis
>>>>>>
>>>>>> [1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com/
>>>>>>
>>>>>> --
>>>>>> Alexis Lothoré, Bootlin
>>>>>> Embedded Linux and Kernel engineering
>>>>>> https://bootlin.com
>>>>>>
>>

