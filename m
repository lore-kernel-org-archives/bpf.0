Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083114A5EA1;
	Wed,  2 Sep 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360936; cv=none; b=dmXTn7Da1GERErXMx/Ts5t/H6AAaQk2V3rEspeTB5Z7P8M3nynyNkiCDzrFne/ZLwxEo77onsh9ArVPVO2zxEHUyH3URvdHElqXdiREGkX2pF/NMbqSWSONqd2U5iIxkK6VkP8NPSwOmqoyYmek7GhNkpyXvNGqFn2ulNgQ0ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360936; c=relaxed/simple;
	bh=z0CJyNgLeNUQxzws5mECT7jNypZ/Oj1miJbOnynyUpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqXmY58rhjXlU5DAZ3x4Fuy04e+dzOHFk9HdYrhtFIUFFt8YZByLhcgKjKlQmZ511sGDq1iHuFWj0TYCYmVe41+Fl0W8jJLbjmz2t2rwrEcBNQLuvImDdUQeTVDi0SGK2RBMS5PKSn7Zn8ajZftXyZ01awOuNNV3M50TUF9uTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOXiRG+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOXiRG+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4281F00A3A;
	Wed,  2 Sep 2026 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788360934;
	bh=z0CJyNgLeNUQxzws5mECT7jNypZ/Oj1miJbOnynyUpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOXiRG+Jc77nN3Uu0SPvM9Oyxf1V3HmWu6daqJpf1TxzTJ7oU1/KUpytn+s8y3bbk
	 I+N/AyUh6vmzAMqHbb/zD1nmmtFR2hxsJ8OnP2dS2LkxBVO1BYEuPSgqMnU1/O/uEC
	 PIYzYfsgyroEQs5rY9e9RYEAQYyA5XWfbVI35flOF42Dis4I9VSDkQqEG+jufzg+oV
	 8u4/5V3PK6iCytWMBwbomPDCcd08LUPRcndlKMSyeNR6kDvIFdMP4qZXhx4vBvbx/6
	 Q1Sb81V+1rtxmO1xdyS6Uw9WzMQJyuj3d814Z2lmkNp/v9vpOf7BYZ7DKNILBJsONe
	 Q9an0OXJUuR5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:55:33 +0000
Message-Id: <20260902145533.DD4281F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D2

