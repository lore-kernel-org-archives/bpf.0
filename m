Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63537F010
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324426; cv=none; b=du5x4JTP9jTVw2VlZzkPV8Cv5ONsjYoP7A/i8u4YFTUyqdSieLNs/e+dgeaDpoHt0tLH2ykB5FqufGMIifpm324dGcQ9izfMvFNkiyKTc90bJZ/d5FJ8bLUyXhYVawa7EqGTx9lz+DhUn/5q1zsg00DCvEJHDCYYAm9YBFGFISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324426; c=relaxed/simple;
	bh=cMOcmTHUjpvGfqMc0Qo0Y96hF+Zqv+4JzJWq5RmuxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh8vdiR++u//N/rl7TXigdfkYvCP4KG7gSZpDk2O7tKRqeT9adIsoa/myLSGVWwRr5094dMtafnuoyJQ3+eM5CvcFhkwCz1PQKTHi6orJrttOaVdSz9GY7A0kLEblM2+hltVnNgjzXhMyZ/glvnrgcE2r6/O2AxCOEqjfmnvPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVdUv9el; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVdUv9el"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso21763155ad.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324424; x=1791929224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zu8zvtnFZnvsuuVYF8CsdMfvYeMKoiYH8K572/QZiGE=;
        b=HVdUv9el8EuckYGOc3Gllqy+x/LNCyEs7BT60qdidhm7dacqfHMfKL4lMS4ghaJ6gi
         EEwHm1mUwtCNSIC7Bf1ojV7HSrrbTszqhYo1Al0SQSC7HLUKTCVzq12EdOk3M4B3R3y4
         xrVNgUwXIwe8WjJmHRiVkFOsqQZt8cOPjbA5TmPw/QH60wSYidwHTGA8e58SUmEoJ2o0
         H0XDeU0MQqUbYyOFEaPEfLE/u4CYwpsea6c1xsExfA3g5yoLW0BcBtJ2Bw4mCoqunduQ
         +HVZnwhBjP4YBZ+W76Pep7y0qSxgWNdHuhUE7NV9tc/uscGVsYgAWpTaXbt7kjhgt+nG
         +Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324424; x=1791929224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zu8zvtnFZnvsuuVYF8CsdMfvYeMKoiYH8K572/QZiGE=;
        b=sBXUt5HeUlW3VHjXS5Oes4p0qmuTUS1hff7dbDuAmyndI6oIsmLHr0RCOoV0xBf5WI
         IkwEht6I/56nLuThJp2JqcAAWN13AIeRxw/r64065VmYuRAzQNoM9gcQ77uAJNS4ufTZ
         E3gY6g0ctUhyjKIhlgToUYF2HrfyagaADNnK9OJwZeyaSLSv9UW6YJPJCvFAqqPV8QPs
         Fw1NuNqjMrwLfhLIfJd/M2C8AWWeV0afIfxrGoCe7xulOeET5qH9+zsiT7OvFnOm0ahe
         6LSOwolivaOMB4piBXKkqxFZMUn1cvN1iOOaQMWUjn5ZNThBKgAU+TsOavekhy0vvDIq
         A+Pg==
X-Forwarded-Encrypted: i=1; AKwUvByytwKxXUuqJW3npqF76r0Pi+4gKtrO7nlXOiaVIlmnbrwucSjAWdNzJ1u+1rlhmF0trqw=@vger.kernel.org
X-Gm-Message-State: AFuF++m36r2nErRg4e5TfiPx8bYoiXp8urqdm6Fs49w9BDuQI19f5OSa
	K2c7sG2uoBGDgZMEE3HHwEHQ4LjV0aW0Q/0gYzu0sjdlNl+tDhlSnAS2
X-Gm-Gg: AYBFou3zOjkLftpuH/rblrzTSri7ZN21CC1vh1Ihjq/hFU+HWsdO5ZG0F8wcAwr9O4P
	epR3xnXr7ykWISQJFqgf8NWb178JQTD0pWxIfA6URxm53JNyPALQHYYJryGiEeaENu2tKpHIZWK
	MJ6Arr7VXdCLM1dqivbASpv1EPE9cUjXHjUqSj++Qe0JcK2UmtnefdlbIqda1yuHKhRoJL0+/7F
	zdIGwIjsg9gNzBOygHRRe3VPtcT/D2l1qCJPnjQzMlZbGru0B0vGfZK8K446Hd7bKVNxoxcF/Bf
	sDtP/7cgOH3FJ7hUkJuoeggl5agNlJvr4WAYp1xVXXuMVg2GyPTazZFTAc9Fmejo/3Av9eyyEjy
	isW2RC+CZ3UHM3H6j5c3mu6cosnxKm1bGzgK42ZnZltR3vMqDgrSmYnqk3t1dI/dxCyJSL+LElB
	wYlYUHvexeUSkL91M3bAiB/QnKEucyRH4JPQmyY8NXglPU7UwpGUNio3gT0gMMX13v
X-Received: by 2002:a05:6a21:70c8:b0:3e0:e5a5:c1bc with SMTP id adf61e73a8af0-3e133db44ecmr268904637.10.1791324423832;
        Tue, 06 Oct 2026 15:07:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-891890f1128sm540284b3a.31.2026.10.06.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:03 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:04:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net-next 00/13] selftests: net: migrate AF_XDP test suite
 over to net
Message-ID: <asVwEyCK0NR4AwE9@devvm7509.cco0.facebook.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
 <asUzHc2Md9qu8Hx5@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asUzHc2Md9qu8Hx5@boxer>

On 10/06, Maciej Fijalkowski wrote:
> On Mon, Oct 05, 2026 at 11:06:52AM -0700, Stanislav Fomichev wrote:
> > On 10/01, Maciej Fijalkowski wrote:
> > > Hi,
> > > 
> > > This work moves the AF_XDP test suite over to selftests/net and adds
> > > a hardware test on top of the python-based drv-net infrastructure.
> > > Since a non-zero effort went into implementing xskxceiver's (not so
> > > great testing app name) test cases, we did not want to completely
> > > abandon it and start everything from scratch within different infra.
> > > However, hooking it up to the networking CI will allow us to run
> > > cyclic tests on real HW; before that, all of our HW tests were manual
> > > local runs.
> > > 
> > > Tests were based on a process with two threads responsible for the RX
> > > and TX paths, whereas the new infra expects two separate processes for
> > > the DUT and remote side, where each side has either rx or tx role.
> > > 
> > > To satisfy this requirement, this series makes each xskxceiver endpoint
> > > a process of its own, so that the RX and TX sides of a case can run on
> > > different hosts, and adds drivers/net/hw/xsk.py, which runs the existing
> > > test cases with the DUT in zero-copy mode against an SKB-mode xskxceiver
> > > on a remote host. The veth test keeps its cases and moves with the
> > > engine from selftests/bpf to selftests/net.
> > > 
> > > ZC tests used to expect a single NIC in loopback mode, with both
> > > sockets on one of its queues sharing a UMEM. Now we step away from it:
> > > the DUT and the remote are separate hosts, and an ntuple rule steers
> > > the test traffic to the AF_XDP queue.
> > > 
> > > The remote endpoint is xskxceiver in SKB mode rather than a plain
> > > socket, so both ends keep sharing the packet stream generation and
> > > validation of the existing cases. This reduces the need for remote
> > > interface being a NIC from narrow set of NICs that are AF_XDP ZC
> > > capable.
> > > 
> > > This implies that during the test run only one side is actually
> > > exercised, so let's introduce the concept of direction per test case.
> > > For example, this means SEND_RECEIVE in XSK_HW_RX will test
> > > ice_clean_rx_irq_zc() routine and in XSK_HW_TX the ice_xmit_zc().
> > > 
> > > BPF's 'test_progs -t xsk' is removed, as well as single interface mode,
> > > which was used for ZC tests. BPF CI therefore no longer runs the
> > > xskxceiver cases. test_xsk.sh is kept, as it is the only run that needs
> > > no hardware and not all tests are currently covered by the HW test side.
> > > We can decide whether to keep the delta test cases, drop them or somehow
> > > enable within HW tests.
> > > 
> > > Thread-based approach had a pacing mechanism that was a simple in-flight
> > > packet counter updated within critical section by both ends.
> > > Process-based way now is going to do this pacing via xsk_peer.
> > > 
> > > xsk_peer, the control channel, carries three fixed-size messages: READY
> > > is the barrier between steps, PROGRESS tells TX how many packets RX has
> > > consumed so that TX does not overrun the RX UMEM, and ABORT stops the
> > > peer after a failure.
> > > 
> > > test_xsk_case_defs.h lists each case with the DUT directions.
> > > xskxceiver builds its test table from that file, and xsk.py parses it to
> > > make the variants ksft_variants() named rx_<case> and tx_<case>, so -l,
> > > -t and -T work as for any other test.
> > > 
> > > 
> > > Patches 1-3 prepare the split. Patch 1 moves the endpoint work out of
> > > the pthread entry points. Patches 2 and 3 drop the single-interface
> > > loopback mode and the test_progs wrapper, which runs both endpoints as
> > > threads of test_progs; neither can work with one endpoint per process.
> > > Nothing else runs a subset of the cases, so patch 3 also merges the
> > > cases that the wrapper left out into the main list.
> > > 
> > > Patch 4 adds a generic rule for BPF skeletons to net/bpf.mk, as Jakub
> > > suggested in the review of the xdp_features move [0]; xskxceiver is
> > > its first user. If that series lands first with the same rule, this
> > > patch can be dropped.
> > > 
> > > Patch 5 moves the engine, its XDP program and the veth launcher to
> > > selftests/net. xsk.py needs xskxceiver, and a drv-net test can only
> > > rely on net/lib: the selftests build pulls net/lib in for net,
> > > drivers/net and drivers/net/hw, while it skips selftests/bpf by
> > > default. The veth test is software-only, so it goes to selftests/net,
> > > as the drv-net README asks. selftests/bpf keeps building xsk.c from
> > > its new place for xdp_hw_metadata and the xdp_metadata test.
> > > 
> > > Patches 6-9 split the engine. The interface capabilities move into one
> > > struct, so that a process can mirror them for the endpoint it does not
> > > own (6). main() is split into setup, run and cleanup (7). xskxceiver
> > > runs one case per invocation, and test_xsk.sh owns the mode x case
> > > matrix (8). Finally, the RX and TX endpoints become separate processes
> > > that meet over a small TCP control channel (9).
> > > 
> > > Patch 10 adds the xskxceiver options that a two-host run needs.
> > > Patch 11 moves the case list into test_xsk_case_defs.h, so that
> > > xsk.py can read it as well, and patch 12 adds xsk.py on top of them.
> > > Patch 13 documents both setups.
> > > 
> > > 
> > > Tested with back-to-back ice NICs connected between separate hosts, with
> > > following net.config:
> > > 
> > > NETIF=ens785f1np1
> > > LOCAL_V4=192.168.100.1
> > > REMOTE_V4=192.168.100.2
> > > REMOTE_TYPE=ssh
> > > REMOTE_ARGS=mfijalko@hostname
> > > XSK_REMOTE_BIN=/home/mfijalko/bpf-next/tools/testing/selftests/drivers/net/hw/xskxceiver
> > > XSK_REMOTE_SUDO=1
> > > 
> > > 
> > > Known issues:
> > > - Every case pays for process start-up, XDP attach and detach and, on
> > >   hardware, its remote commands. We used to configure resources once
> > >   and then execute the whole test suite; it doesn't seem to be
> > >   CI-friendly and it is preferred to have each case's resource
> > >   management separated; that on the other hand increases the
> > >   execution time of the whole test suite.
> > 
> > [..]
> > 
> > > - The XDP programs redirect every packet, so the link under test must
> > >   carry no other traffic. SSH and the control channel go to the
> > >   REMOTE_ARGS host, which has to be reached over another link.
> > 
> > Will this work on NIPA?
> 
> Yeah good that you're bringing this up, I see NIPA has a e810 setup within
> same machine which is not what i tested on my side. This means the
> assumption/requirement of having isolated link under test has to be lifted
> as e810 cards on NIPA will carry management traffic via same link. I'll
> add XDP prog logic as you point out, thanks.
> 
> I also hit the ice bug after connecting interfaces within single machine
> which was hiding from me throughout whole local testing, during RSS update
> where we only want to touch indirection table, symmetric-xor hashing was
> being turned on which caused later rss operations to fail; I'll post a fix
> to iwl-net and include some heads-up to v2.
> 
> > 
> > I took a quick pass, nothing pops us for me. The only thing I'm not sure
> > is the bpftool dependency (whether we need to build it or there is
> > something on the system).
> 
> We need it due to skeleton usage and other change was also utilizing it so
> I thought it would be acceptable.

No, no, I'm not questioning the need, just not sure whether we need to build
it in the selftest makefiles (like bpf selftests do) or it's ok to use
the system one (if there is one).
