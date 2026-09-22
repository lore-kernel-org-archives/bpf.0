Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09E2773EC;
	Tue, 22 Sep 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105510; cv=none; b=Qv81CoFmkrqtRg8QXv6QoBbO5swGtPX9DU+o04xKbDcOZdZEQV6+wbx2CeF8WxEEneb1ZGDHm3Jcs0mKj8MHIf+cG29IveD1VSJ3Sk7mnrbBz9GMRf6FgulgbL9sZZ5N0I2CmIqmfolcFVzzY8XFLsKb5UT901XwRGC10QRoh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105510; c=relaxed/simple;
	bh=vI8yngDyziunjDL/55/EmfkFnwob0EsgJAffNrHK2b4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YUFSqqndZtXzjKyd2Uko7KcKRrmTmYgs3TAbLq/Qb/seU22prNLi5q/kQ9h91a0iBWOtZzPVaKs+lC21XLvOt/87v0X3qOGaaXbEQQe2pBI5raHEpvxbHQF4dB61ZdMiZ8TmJpmz/hpZPoYNF240RMsdjjNK59ZtmXG9mITf4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R51LS+Fq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R51LS+Fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309901F000FF;
	Tue, 22 Sep 2026 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105509;
	bh=vI8yngDyziunjDL/55/EmfkFnwob0EsgJAffNrHK2b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R51LS+Fqfw3TLy4rSa7nxKkgBV/aivPp5SptVDK3A+RwHGZ/Mz0FbKxiw6WOoZzmk
	 CHnLhrxeq9fK3MZsp3bQB3sy1MxZ1msyx7jHzdkNeRkoc6bEtXba7jF+NpCSHY8S2A
	 HFXD801UdD1J53k4j+0/ZBDs/quGNoTXpj9xdP3uSwrszdM/HAmzTO0MNCLw9R1fzX
	 y//oaa0Pg97/cqobuNGtgPf4REo80BHngv/wL73DTbucc/81K85MwSkPEzty5wQQOO
	 cB6owxY6N/5y113rG1L24z4hCupTScQaIN0DA4f8mhFX7aHmPabIzMKZ/MFlqdn9Ir
	 aMLKPEj7nJtkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] arm64: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <8fdf9691eeb33df50ad1257eb36e9ed91a114afc.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <8fdf9691eeb33df50ad1257eb36e9ed91a114afc.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:31:48 +0000
Message-Id: <20260922193149.309901F000FF@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D3

