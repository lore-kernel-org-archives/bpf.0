Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85A37E5EE;
	Wed, 12 Aug 2026 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786501733; cv=none; b=KD+kZVXwiLMZK0Qrv1tKxNDSSs73x9bxnoywJ6B/wYexzgTfOiF03nd3KI6lARElTuAVppPfpXE/1Za/dm17fAKYZs2e/jdd6vlox8jzD7jFS60Bgojt+EnCKIkcY++0jajOFrgdpT48I0D+mIpTztn1jPAyWFai5M41ldaWKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786501733; c=relaxed/simple;
	bh=BYlFI8df0nk/XmspxA12XeiWyhM+rWeH69p6jDMG/WM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UxhYB+GReaDfPdYsPOOtX9bmVHosmCEugO3UdERYUAvKQKCCnt1F7erRb8qNum9GfKrS+D1toYuiKTPbqlwtpTSF4fXubIZDo5R2rnHQE6+u8BkxcGLiAhaBXXpQcrtz/07faWYoleSXWB9p7eYHdJE30BX0/1i5LT/t6/MbHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhwHCJxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhwHCJxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55641F000E9;
	Wed, 12 Aug 2026 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786501731;
	bh=1SVdmcxEwCKrMZ0Idfbx3Dp++1/rG7Dqk1HcJd6ez5g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DhwHCJxVud0c+QTwqAo+zI/cSAp5KeRJbuUNH3ygdfs312DXwk0vZCOKm0pLQVqQe
	 P+ExKgLvYsRryp/sXn7mskjX1KCXcbaoTH/wMy0zZ0m5pvdVrSTNje3W/Qigdp7IDc
	 wqrQc9Ui9JcpN7ji7XM5unpGPeJyG0Lp+ZD5Sfk/v+LUk4b9JYI3Wbby+OsOP5/lc7
	 eEBXY8PK64JDkYryJTD1jRMtUz+koertSl2JGgAk3aoD8/aez2dIDDKmwGiByL5j/L
	 /gIRn8mmQRyPZCpvgguh90SMcS2B+wYD1IuAEfkoEzzEIPw0FH+EB/j/8GZMj2jYSX
	 Zx1J5WeXT0yKA==
Content-Type: multipart/mixed; boundary="===============1841659783378056855=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a2ae9d8a6c2ddae7f910225c821cbc06838bb7689c39c6606970f03f2c469f4@mail.kernel.org>
In-Reply-To: <20260807134209.3794735-6-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-6-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next 5/5] selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 02:28:50 +0000 (UTC)

--===============1841659783378056855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> If __pkt_stream_generate() fails midway through building per-socket
> streams, the original code overwrites xsk_arr[i].pkt_stream with a
> partial or NULL pointer before all allocations complete.
>
> Allocate all TX and RX streams into temporary arrays first and only
> assign them to xsk_arr after every allocation succeeds.  On any failure
> free the already-allocated temporaries and return -ENOMEM with no
> xsk_arr pointers modified.

Does the commit message accurately describe the problem being fixed?

The pre-patch code NULL-checked the allocation before assigning it to
xsk_arr[i].pkt_stream:

    pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
                                       pkt_stream->pkts[0].len, i, 2);
    if (!pkt_stream)
            return -ENOMEM;
    test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;

so xsk_arr[i].pkt_stream would never hold a NULL pointer from a failed
allocation. __pkt_stream_generate() either returns a fully initialized
stream or NULL (it frees any partial allocations on failure), so no
"partial" pointer can exist either.

The actual bug appears to be different: when an allocation for socket i
fails, sockets 0..i-1 already have new streams installed in xsk_arr,
and both callers (testapp_xdp_shared_umem() and run_shared_umem_test())
return immediately on error without calling release_even_odd_sequence().
This leaks the already-published streams and leaves xsk_arr with a
half-replaced stream set.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31554903166
--===============1841659783378056855==--
