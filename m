Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FE33DEC2;
	Tue, 22 Sep 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105610; cv=none; b=RT+w7RbSy5bg790UhZxl2DszS1oIv+43kfKcWeN9rym3gLLmaItmtu4cHZGUdbUnvXSVw1ypIrr1n5lXOApDzo2iE3H7iMkA/3qgUbvULLkLc4pKALwk6eqI6kBaitnXyDuDTDzBA9AR0WAZfReXLBxk9IjrFYKn6ViR6joATEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105610; c=relaxed/simple;
	bh=zsAgMhRu6W+KL17jcSGMbQugsdfd+SO/3H//AgLfaL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYn7IK7Fs6rsZZgJpk3KXUm2vH/vF6jkSiV+6x3jRK80O8jcfxliav0VJbxBMcErRkfj/mghk6L/A7ktiIMtQ/f9hlw3GSRP4QzPqV4wpDoJ0QZqqU1++DsBJ0w8MIDc69wAhkESstLbM505xh68cWNSAdNrnWWw0uyx7+aoduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKxTX+yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKxTX+yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8351F000FF;
	Tue, 22 Sep 2026 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105609;
	bh=zsAgMhRu6W+KL17jcSGMbQugsdfd+SO/3H//AgLfaL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKxTX+ywNyGMbmOJgM3m6z//1VKWYLaA5dj5DGtT3p5BSjGHuv3wazqMVHEoEk4Qw
	 QKswjoXSXibcPbcv+/wSKDTCQqnWQt7WwM5lcoEVClNhaKF69srkwfYLNA603ltLZZ
	 svddsA4ORr5LTpmeZqsT6mB/P/FmS3Xyb5PASCHug9ymmtYM245fIA0ZxHDoBrXue3
	 sMqe99sK6A8fYuM4y9I4g/uOrkHrEqMY9avW9kjNzLJU9rUN8iCQMKQbogPH/adQkp
	 +jIrkBe6L3XeXbHXHAphRp2aKgzUGKIkbKX2zRmhg+K6UEwlS+XI6MnRCSuko0Etjw
	 +3P/PolMTClPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] sh: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <5dfecab68baf591c7d4c9778550bdc134f81c00e.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <5dfecab68baf591c7d4c9778550bdc134f81c00e.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:33:28 +0000
Message-Id: <20260922193329.3A8351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D10

