Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1B4A2626;
	Tue, 22 Sep 2026 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105573; cv=none; b=kLB2vEwr0CrRX1Hw+v2lmH4z0HbH2ZyEdvEp/VkSR/xxmPric804bDe70q+c0tpXSg0w+n2zM6a9bhEaQgGohD8AuO6cGzNBC0KDy55Ca4z/BOQ/hPxDtO/ffMiaSUTimlI5wEtVgOBLHrYO9ZOgUkwSez0j81Hdx7FtWB92SzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105573; c=relaxed/simple;
	bh=/TqAAIC31aqSnxm8mNkGeqVGMLaVJNeGEpYfUlvjUEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+N1O+GO82/pbBk5sVUAELtsE3B6buj1JIyRUtVErMyURrCShvSyfLx8W9kh8vgoy1xNG/NM3Z9kvYcQRsd9CCP79rjJggTqADNu+FKatFIMPR3rEH0eB8hWeo85E1Rpa7dd3tpTfhIeDEj4kkOF3M6q8CYKbFBzJn8WIRXpQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhtxPbA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhtxPbA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748341F000FF;
	Tue, 22 Sep 2026 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105571;
	bh=/TqAAIC31aqSnxm8mNkGeqVGMLaVJNeGEpYfUlvjUEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhtxPbA14QXEokNFqUlEBxdYgr4WHG1ix4U+bLbF+Ic7UsYVtkONzqDWVJCZsSXWI
	 8oefuW4jzeiP5i9ew0bASIdDXQisJOYM0VPFSs4abdKQcvXm8V3gjABKJ0PF+fiqgM
	 9SRhGF39EKdtYENE4Y6NtWcMMNYPGfwLWOUAt5aVucvmFAJlrpvLCSio2AFyxXXXcH
	 cX0m3V7F6FOmUYoaiAp57AKXa6F5XpaFkY7DKSAvQqr2sSHnGcsXTPwe9MR2wmfIZj
	 Jmn8Hg2zdmTL/0I00+8StfoNBxEiOoTlo2ovIbwPGZ9PFxjw9oMtwS0Qj0SSR2kve9
	 eF1BUqg5tq7iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] csky: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <6081699cf912416878c42769821a6c6a477a5e13.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <6081699cf912416878c42769821a6c6a477a5e13.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:32:51 +0000
Message-Id: <20260922193251.748341F000FF@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D4

