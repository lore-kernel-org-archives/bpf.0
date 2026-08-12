Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8C38236F;
	Wed, 12 Aug 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502569; cv=none; b=K17kDm9a8iHSRDMNE+nNIZbZAZr1Eaz0XendhZZWUoYNieaH2ZcCJxLU+DWiylXfmEUzDQ8Nr1MComSPUm9BirBouxiTJ6Sar6MZqPWGeK/DiqvYGBSj07GWF0XofbatGuAx16SK3Qixc7hRRYtj/jpP1ma2dzbREc6Q61mNY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502569; c=relaxed/simple;
	bh=DogYnRoH2rCv0Sc02hycEOC3ptTeWOer3/WZVP8CxLk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DPM/MpiMm6AqGTzkC0dRE1JDn+uM7UdBHMD+cEmSDMuKdwIEDM4EnkRQCZyXTXcVsWXK48xJsUHSJB+wRlgryE7bHPresB27jA5PnaJSVF74JU1jWwf/N1CyUe3/xgyJzmUAR0feX5OD2xuI1YXRgeU9T5n+SXkfDCH9PbrTm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae3AR6kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae3AR6kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5411F00A3D;
	Wed, 12 Aug 2026 02:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502567;
	bh=KoVcveBeW26/mR3eqODG2tsuZaCPSTMLMJrPuxsvt/Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ae3AR6kvl6+usyi2PDxV/qGkt54nBrpB0Zy1GRmtn8ccMbQw9y3j+k2JcDpUS7Wnm
	 qi1rE51XKl5/yZ4OXiTQp2MnL2hvxi+BCL+ogJWc/bA62mS/JA+aCrl2ZPNJwIJH/X
	 avl1CsmxLldaVOoXKsmWLoAXovfHB7ALcUGz/7R9G3zZYOVtLJ7/uavMqyuXYS6uZX
	 jLxZ1+ZRsQpsxEuoDdBiP8cmgepxse60qoqc+Zi/fbrY6xOKhIQeBmCvFI6ijhA9cA
	 URqR0SYPbaMwNknBh0gl3fZxRrVJ5wztaxSBaQfQAh7PH3pCv/1ViAyiRI+8R57cp4
	 lwRqcP4uDFlew==
Content-Type: multipart/mixed; boundary="===============4864086236107815705=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <432070173bb986e48f8bdc1373590b8ace7ab192e8505d9f1343df78ab34d2e9@mail.kernel.org>
In-Reply-To: <20260807134209.3794735-3-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-3-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next 2/5] selftests/xsk: roll back partial socket setup on configure failures
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 02:42:46 +0000 (UTC)

--===============4864086236107815705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 4ffc9af96ac7d98a2901bb6fe522a2076e0c73b4
> Author: Tushar Vyavahare <tushar.vyavahare@intel.com>
>
>     selftests/xsk: roll back partial socket setup on configure failures
>
>     When xsk_socket__create() fails after all retries, or when busy-poll
>     setup fails after the socket is created, already-configured sockets for
>     the same ifobject are leaked.

Could you clarify which failure path causes the leak described here?

When xsk_configure() fails, the worker thread sets test->fail:

worker_testapp_validate_rx() at line 1719-1722:
    if (err) {
        test->fail = true;
        pthread_exit(NULL);
    }

worker_testapp_validate_tx() at line 1676-1686:
    if (thread_common_ops(...)) {
        test->fail = true;
        pthread_exit(NULL);
    }

Then __testapp_validate_traffic() tears down both ifobjects after joining
the threads:

test_xsk.c:__testapp_validate_traffic() {
    if (test->total_steps == test->current_step || test->fail) {
        xsk_delete_all_ifobj_sockets(test, ifobj2);
        xsk_delete_all_ifobj_sockets(test, ifobj1);
    }
}

Since xsk_delete_all_ifobj_sockets() walks slots 0..nb_sockets-1 (the same
range xsk_configure() iterates), the already-configured sockets should be
deleted there.

If there's a failure path that escapes this teardown, naming it in the
commit message would help clarify why the rollback is needed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31554903166
--===============4864086236107815705==--
