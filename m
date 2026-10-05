Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BF4CE67B
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223619; cv=none; b=AJcdeqbJ3Xeahi1kWiYVGvSigt1QyFrKF7ZD1jyVXdtU/KXEYBeNoklea/2otHGea4/mfA7cWAs2sVdDFaKZNVea82zv/6g8y2V7zAF6vsk2YxUUfF3q4QC4Oq4XxXvrcHkgs+Fovari7vALToDEeUWY0/NSM7C272cGSu/2m8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223619; c=relaxed/simple;
	bh=/FAsQhlFlHqN2Nkl1Uwt0ZLtmve/psgYEW9sAsYXCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcu5dELmsgFhyonW/2hYS6NfakI1kFWrUC92nLU+3g3fSv2nNmBMzpYCPpKZhhMvKur5eFMH5zSp/a2QiNwrHI8AUCA3eoS4cdo5u06NUqdDEDJ6hGP9Z6TRUQMPeQ5bKSRFGxKws7/L1fYkSQ3bkCsjEhu+I/beMtRZdjc9w/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1cQrEBo; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1cQrEBo"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3a0aa5e2b20so482590a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791223617; x=1791828417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7NXEHSFquRYA0GwnQVrP8+OZwHxFYO3UslI6dCtMRM4=;
        b=D1cQrEBoxzVh3tD6SOz5lFFXvcCOP7FyROc/jvgsdh4z3GrqvnrAsbWladMMGMKYuN
         xLTG/hWYXhKi3HjTgFmdCScwGXkv3nOPZsbg/0jfyr5L5+H/Uxm9cYmngmC18FKU1icK
         tuXPmAiPWRLZ4byHGIApP5H80WV7YvXiI+jH89a9sEhbstpCclw6dN9zGLl0PQoilMuS
         lt2GSnukfqXz9DA20xerB6hihP6ARQFFV4SxajbThTrsHTpm3uzj4jtcDeZ++4rDTSfk
         oRUTUJF1zsutNBB9zw2LqLmaaGrTBFj4EwXWhr8oZjsU+6f78kVfTeE2ROFNsxP9Sfr2
         eoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791223617; x=1791828417;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NXEHSFquRYA0GwnQVrP8+OZwHxFYO3UslI6dCtMRM4=;
        b=NIo4RhI1FfHwboVSPVlDVUkrAXqJBfMnMscWNdB7EoPKzZ5B+09kXfaWGLDs3ABPp9
         aeg08UUL0cOWs6RoQrhd1bkN7V3jbPmGjH1kGlZD0IWAhu4VgN1mWL+qtsKsVuwZIfLj
         LwwDlA0wGDhybamWcZ0upAFUj0JltTr/uOd6QOn9csA3DTxtD+mlruPT58KlbfQULHLD
         k8KY/Qt8qGdxY1+k2wLoCYnUCXM1Zf+Ma0Yg9z5nVWz6eS0i908rvwvSlTCxi4Zj1vE6
         PM5+IJL5cpfU7ozlvHWX68GnaG9C0hTAHy3yaQlvNlmq05ADKoPvBuU1KlGrANsxKsbn
         JfKA==
X-Forwarded-Encrypted: i=1; AKwUvBxEIgkNNOgV62oAaBiup/PoljAQUisqOSV45yFC2qkSm6+C5dfwaV0ZF9zowVGjj228FQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKy6PtX7rRZJCocL7I4zEct/o4mxOWd7jIiUpZfULytrv3Yn6qA
	xNErQ7e60dHPoSR2egGwBwrfssY7Rq5K2n6a82qdVHvsX6T2LUtDHKmT
X-Gm-Gg: AYBFou21joCQ6jhaEsUagwuGy7YoirIIjPlkl2D2xyb6RGqNXoz6bW795Cm/iIuy++u
	tiv5gkicchx47ZA3BbMpaXyh9Wui7NPEK6ju9tMLLHwEMGqT/6UJBWU8oHbHN5oEhjKjbodc/l/
	kvc5kFqHRvjc+p975R2p5c82+1iFDoel8RMobKJ47uvdGpc15YuVzR46AJqOeSU0BaD5JipwIOI
	oqwqKePvReCazWRUGbesOOvB/Ni1xp3ZeOcOYeskcPtFWp55wQ6naH/vTjKacTmjKXL2EaSlS/w
	N7+XSBYUEz5Fv7PQLu8uwPbemPDELFRbxcni/nswE2+f8c0r91GQeU3AOh+dQLriB4U+JwDryCq
	HjtdAJYE9SDaSNWpLvTsN0PG9aD/2OrEveawXvy/vjYJHaljNJswCm/EEQJ9s0iB0G4hBAuXVvP
	ep9t1fhqYRAj4jpPTltxetTed25wcmForGNq5TQ7Kj7KGVJjGjAuN0PQYC8K2QeiuD
X-Received: by 2002:a17:90b:260b:b0:3a4:f1f9:1cb2 with SMTP id 98e67ed59e1d1-3a6ce6b4005mr9731383a91.13.1791223616729;
        Mon, 05 Oct 2026 11:06:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7e4b00de6sm4423426a91.1.2026.10.05.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:06:56 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:06:52 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net-next 00/13] selftests: net: migrate AF_XDP test suite
 over to net
Message-ID: <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>

On 10/01, Maciej Fijalkowski wrote:
> Hi,
> 
> This work moves the AF_XDP test suite over to selftests/net and adds
> a hardware test on top of the python-based drv-net infrastructure.
> Since a non-zero effort went into implementing xskxceiver's (not so
> great testing app name) test cases, we did not want to completely
> abandon it and start everything from scratch within different infra.
> However, hooking it up to the networking CI will allow us to run
> cyclic tests on real HW; before that, all of our HW tests were manual
> local runs.
> 
> Tests were based on a process with two threads responsible for the RX
> and TX paths, whereas the new infra expects two separate processes for
> the DUT and remote side, where each side has either rx or tx role.
> 
> To satisfy this requirement, this series makes each xskxceiver endpoint
> a process of its own, so that the RX and TX sides of a case can run on
> different hosts, and adds drivers/net/hw/xsk.py, which runs the existing
> test cases with the DUT in zero-copy mode against an SKB-mode xskxceiver
> on a remote host. The veth test keeps its cases and moves with the
> engine from selftests/bpf to selftests/net.
> 
> ZC tests used to expect a single NIC in loopback mode, with both
> sockets on one of its queues sharing a UMEM. Now we step away from it:
> the DUT and the remote are separate hosts, and an ntuple rule steers
> the test traffic to the AF_XDP queue.
> 
> The remote endpoint is xskxceiver in SKB mode rather than a plain
> socket, so both ends keep sharing the packet stream generation and
> validation of the existing cases. This reduces the need for remote
> interface being a NIC from narrow set of NICs that are AF_XDP ZC
> capable.
> 
> This implies that during the test run only one side is actually
> exercised, so let's introduce the concept of direction per test case.
> For example, this means SEND_RECEIVE in XSK_HW_RX will test
> ice_clean_rx_irq_zc() routine and in XSK_HW_TX the ice_xmit_zc().
> 
> BPF's 'test_progs -t xsk' is removed, as well as single interface mode,
> which was used for ZC tests. BPF CI therefore no longer runs the
> xskxceiver cases. test_xsk.sh is kept, as it is the only run that needs
> no hardware and not all tests are currently covered by the HW test side.
> We can decide whether to keep the delta test cases, drop them or somehow
> enable within HW tests.
> 
> Thread-based approach had a pacing mechanism that was a simple in-flight
> packet counter updated within critical section by both ends.
> Process-based way now is going to do this pacing via xsk_peer.
> 
> xsk_peer, the control channel, carries three fixed-size messages: READY
> is the barrier between steps, PROGRESS tells TX how many packets RX has
> consumed so that TX does not overrun the RX UMEM, and ABORT stops the
> peer after a failure.
> 
> test_xsk_case_defs.h lists each case with the DUT directions.
> xskxceiver builds its test table from that file, and xsk.py parses it to
> make the variants ksft_variants() named rx_<case> and tx_<case>, so -l,
> -t and -T work as for any other test.
> 
> 
> Patches 1-3 prepare the split. Patch 1 moves the endpoint work out of
> the pthread entry points. Patches 2 and 3 drop the single-interface
> loopback mode and the test_progs wrapper, which runs both endpoints as
> threads of test_progs; neither can work with one endpoint per process.
> Nothing else runs a subset of the cases, so patch 3 also merges the
> cases that the wrapper left out into the main list.
> 
> Patch 4 adds a generic rule for BPF skeletons to net/bpf.mk, as Jakub
> suggested in the review of the xdp_features move [0]; xskxceiver is
> its first user. If that series lands first with the same rule, this
> patch can be dropped.
> 
> Patch 5 moves the engine, its XDP program and the veth launcher to
> selftests/net. xsk.py needs xskxceiver, and a drv-net test can only
> rely on net/lib: the selftests build pulls net/lib in for net,
> drivers/net and drivers/net/hw, while it skips selftests/bpf by
> default. The veth test is software-only, so it goes to selftests/net,
> as the drv-net README asks. selftests/bpf keeps building xsk.c from
> its new place for xdp_hw_metadata and the xdp_metadata test.
> 
> Patches 6-9 split the engine. The interface capabilities move into one
> struct, so that a process can mirror them for the endpoint it does not
> own (6). main() is split into setup, run and cleanup (7). xskxceiver
> runs one case per invocation, and test_xsk.sh owns the mode x case
> matrix (8). Finally, the RX and TX endpoints become separate processes
> that meet over a small TCP control channel (9).
> 
> Patch 10 adds the xskxceiver options that a two-host run needs.
> Patch 11 moves the case list into test_xsk_case_defs.h, so that
> xsk.py can read it as well, and patch 12 adds xsk.py on top of them.
> Patch 13 documents both setups.
> 
> 
> Tested with back-to-back ice NICs connected between separate hosts, with
> following net.config:
> 
> NETIF=ens785f1np1
> LOCAL_V4=192.168.100.1
> REMOTE_V4=192.168.100.2
> REMOTE_TYPE=ssh
> REMOTE_ARGS=mfijalko@hostname
> XSK_REMOTE_BIN=/home/mfijalko/bpf-next/tools/testing/selftests/drivers/net/hw/xskxceiver
> XSK_REMOTE_SUDO=1
> 
> 
> Known issues:
> - Every case pays for process start-up, XDP attach and detach and, on
>   hardware, its remote commands. We used to configure resources once
>   and then execute the whole test suite; it doesn't seem to be
>   CI-friendly and it is preferred to have each case's resource
>   management separated; that on the other hand increases the
>   execution time of the whole test suite.

[..]

> - The XDP programs redirect every packet, so the link under test must
>   carry no other traffic. SSH and the control channel go to the
>   REMOTE_ARGS host, which has to be reached over another link.

Will this work on NIPA?

I took a quick pass, nothing pops us for me. The only thing I'm not sure
is the bpftool dependency (whether we need to build it or there is
something on the system). It looks like NIPA failed to apply and run it,
so maybe address 'redirect every packet' and rebase+repost? As long as
it passes HW tests we should be good :-)
