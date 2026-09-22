Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DE477E2E;
	Tue, 22 Sep 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105588; cv=none; b=G+dRObbbiyxqwcJxWGmXV+3BRoiYar5g3Drry6Tg3ajGB5hmQMF+ylKzcbchNFNrm/EzF1R9QB7GoqqZEpyUf7Am6PsR0mXWpELHCTrdTSylB3vslZxcHR+E37a7uXk62ZdkiMUpZnsq6OlAE/Co/f/8rQEhFNO80f/ta+N3ICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105588; c=relaxed/simple;
	bh=Nid0gJkUcKWca5fHSmfx7eTTLb32scrWksMui31rPJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d66DjAr00a7pQxQA4BcUNTwJK6tfUNaMlO+qPTn4+YO1D9Un9OH7p5olydVh0I6nMPoM70XgIVofBTtSj2OSaDJeuKMHG2TOgERQOjC8OLTOmyAXyRM1y8wbrfaXYE5lSPA1r7Q0wC4HAZh/77g9p+YhGKkIKg7aNiEZ7T43jA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFlbTuhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFlbTuhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B661F000FF;
	Tue, 22 Sep 2026 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105587;
	bh=Nid0gJkUcKWca5fHSmfx7eTTLb32scrWksMui31rPJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFlbTuhVdS/O2oQVRiRXyaJ26AuLuIvnsVw2uF02oL22vUB4RpsoRcubZ0p7kz7oc
	 Qm2dR2ZNyjiD9H9goXiMI1oDbSSQiAAIt4AWNDiupI5qYIHrs1gAtCnC4jZ4ETLm1e
	 GfZY33tNUycHWIUnSjWiJ7y8Q+BEAVQo6Qs8IgK2/w6/A1ACoZaOywbHce8J6ucEpw
	 AQ7f7QPZXsTGIuJ6K+RMSWz8aSIC6kdJ2VyBikk/GmEOWG8JLaSGcAP+Qt5QDBuISl
	 gwIGzGbelwGElExET2FlXJn9ys0gMxU2iddgTnWz4iJB2Uv7SqkrF/eIZpgYuiln6V
	 gT5ABzcvISICQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/14] mips: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <682a26fb450b72cd72d438a089093b7ef42a825a.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <682a26fb450b72cd72d438a089093b7ef42a825a.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:33:06 +0000
Message-Id: <20260922193307.36B661F000FF@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D6

