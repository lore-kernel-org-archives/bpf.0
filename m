Received: from kmail-prod-ay-skadi20.mail.kakao.com (kmail-prod-ay-skadi20.mail.kakao.com [220.64.109.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD24A2E21
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.64.109.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138186; cv=none; b=uoMXsct15zjL2Gq/Y71Iw92na0mnL9D/fmr2p1hpEY7RNSo8E5IKaTcBKk/bWIAA9HGPegduehp6aSA210tHpPTHGWz+DRZHgb+Fo/gHeQ/zOX2Pvwu7xjkuOu5suSOi0LNH/Ni1GZM9yjqTp2Aik2tThW3A0lC4p5PkgnL0Wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138186; c=relaxed/simple;
	bh=i9e2Br03g574hin3M4SwuDNyIeapUGVAdu46hmT7hcY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SUe/6LrQsbRRKAnqBBJTPj+XFGXwKWyTABc/X5e19LQGZUbO8SPPiXK7ZAo4HgwAPM5Uc0RwEmZ1ppV5Ur4ENWz3NVJI+jEZhBSbQRnlcfd0JDSwq7qbNgxJlZQWZI4p26TBXX5Y4OV/8ikUNmWvQwKmUiX51ZbyEIqyAEWFdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kakao.com; spf=pass smtp.mailfrom=kakao.com; dkim=pass (1024-bit key) header.d=kakao.com header.i=@kakao.com header.b=Pm+Yd66N; arc=none smtp.client-ip=220.64.109.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kakao.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kakao.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kakao.com header.i=@kakao.com header.b="Pm+Yd66N"
Received: from 220.64.108.50 ([221.158.213.82]) by skadi-sender of skadi-sender-normal-prod-deployment-75cdbddb7b-m4hl9 (10.240.28.115) with HTTP id 20260716024535.1ogY5_ZgTdmwA4CzyWx1Hw@awo.kakao.com for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 02:56:23 +0900 (KST)
Received: from [192.168.1.135] (HELO awo) (221.158.213.82) by skadi-relay with ESMTPA; Thu, 16 Jul 2026 02:45:35 +0900 (KST)
Message-ID: <20260716024535.1ogY5_ZgTdmwA4CzyWx1Hw@awo.kakao.com>
Date: Thu, 16 Jul 2026 02:45:35 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ko
To: stable@vger.kernel.org
Cc: mattbobrowski@google.com, daniel@iogearbox.net, bpf@vger.kernel.org
From: oxsignal <awo@kakao.com>
Subject: [STABLE REQUEST] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if
 BPF LSM is uninitialized
Autocrypt: addr=awo@kakao.com; keydata=
 xjMEaj29sBYJKwYBBAHaRw8BAQdAw70uTjoir+cAyBh4bE41+T3ZcY8JesXsX3fS9/RLqjTN
 GG94c2lnbmFsIDxhd29Aa2FrYW8uY29tPsKZBBMWCgBBFiEEGv1NEb7fVFTMT0j+R7bglptH
 GOEFAmo9vbACGwMFCRLMAwAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQR7bglptH
 GOHMqwEA6mrPjV0UgHUnEdJFO835SFkJSp0KSedPk+pBE01G4zcBAPZ/e4sf0lVjJY89KTxn
 4RB4Eow8xC44CQNADA4qTQ4GzjgEaj29sBIKKwYBBAGXVQEFAQEHQEWbznwsfynGj+y39+0F
 FbJkriqjdRs3p7yB8CZbzpI5AwEIB8J+BBgWCgAmFiEEGv1NEb7fVFTMT0j+R7bglptHGOEF
 Amo9vbACGwwFCRLMAwAACgkQR7bglptHGOGoxQD/W9GDBLtwyqik5drzIqHifwNtoiAu9K0Q
 KAU76xfh47oA/2qtEH7FrQ72egFJtQdY+zJn+tqi4I6wG+lqM4v5itMJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Errors-To: awo@kakao.com
X-Kakaomail-MID: 20260716024535.1ogY5_ZgTdmwA4CzyWx1Hw@awo.kakao.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; t=1784137535;
	s=1444202050.kakao; d=kakao.com;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID;
	bh=i9e2Br03g574hin3M4SwuDNyIeapUGVAdu46hmT7hcY=;
	b=Pm+Yd66Nwl1ictQiyTj9OmsmnsquEKaSGsyJdVRZZSHN9eAGPylNeXQmadR2ZNQV
	sHuZVRowoKPK9ybiboo2s88HULfullEHbU9cJ+b44yRN7h7GdcejUerg/lJK+fLkqa9
	nwA4sXpeaW64LffwiqO0GfiPabi0Z7axS8u1q/5c=

Hi,

I am the original reporter of this bug. Please backport upstream commit

a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4
("bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is 
uninitialized")

to all affected supported stable trees (5.10.y and newer).

When CONFIG_BPF_LSM=y but the BPF LSM is not enabled at boot, creating
and updating a BPF_MAP_TYPE_INODE_STORAGE map can use an uninitialized
inode security blob offset and overwrite the rcu_head.func callback.
Later cleanup may execute a NULL callback and panic the kernel.

The issue was introduced by commit 8ea636848aca
("bpf: Implement bpf_local_storage for inodes"), included since v5.10.
The fix has been in mainline since v7.2-rc2.

I reproduced the panic on unmodified official Ubuntu cloud images:

1. Ubuntu 24.04.4 LTS
    Image: 
https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img
    Kernel: 6.8.0-124-generic
    CONFIG_BPF_LSM=y
    CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"
    Active LSMs: lockdown,capability,landlock,yama,apparmor

2. Ubuntu 26.04 LTS
    Image: 
https://cloud-images.ubuntu.com/releases/26.04/release/ubuntu-26.04-server-cloudimg-amd64.img
    Kernel: 7.0.0-22-generic
    CONFIG_BPF_LSM=y
    CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"
    Active LSMs: lockdown,capability,landlock,yama,apparmor,ima,evm

In both cases, CONFIG_BPF_LSM is enabled but the BPF LSM is excluded
from the default CONFIG_LSM list and is inactive at runtime. This
demonstrates that the bug is reachable with default configurations of
supported distribution kernels, without a custom kernel build.

Thanks,
oxsignal
