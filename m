Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C884A5EC4;
	Wed,  2 Sep 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361347; cv=none; b=i7lCv0WtOQEbz5og/QFDbS7vdkdtEPfoG6vKOWZeo/NkUio2koxRcpoBx5+V8YgXcLtbI1FKH+J+l1aL4OxIqNM36DLXuflW4Z0A+B2ruEViIhnbEe1JlvUqPN6mjH/Zj4q5KRevZ0I4S2ivwV/7CQuoAJDqi8wyAFg7Pi3n5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361347; c=relaxed/simple;
	bh=OHeP7T2aIyy87qxh3zVbxv0dlJ9roJ71cijAkx56z7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GajBoOD5yNByPAyj0gszDNEdjlYwuXWpJo+dqApyBJNXx4wN06rCh0fkB65YrhZw8OW0jXA/glMDnGinNn1Um634nRvqMQMYJy/GneyVyR6xwt7qyJ5s9R1TDXAjcaL8dQ2AsmWddxJRgIDPDzOCZQwrU6J8eJJB2y5+7R5WXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuzZtJ1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuzZtJ1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA321F00A3A;
	Wed,  2 Sep 2026 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361337;
	bh=OHeP7T2aIyy87qxh3zVbxv0dlJ9roJ71cijAkx56z7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QuzZtJ1LA0EPwE00mmXSkwAyre/msFLhRpU4Ki1h5pe+ee8+s3gRMw8mwOFUO8pTX
	 Ck2gJrYGKvtakWvJ6rrGys+kqwp9FMarVQpCbYVCysOWUyniOM/gCGkcc/RBKNbnxD
	 Z3G+cWGFotBvhWjLTctAok3fU+F/20zAediKJJuURB3b20PaglrsJdxaOUs00Rtn50
	 NzQMALlOHrwuoh64I5Zthl23AncGD/rpMPbBT1pSg46iiLYA1EKBwSOBSfFdciH95z
	 WrRLkSxOjia2wvyioSidyv+oEQop2He+gLmiCiTuZAbGIYfrbQGUT7Q3CazOE5e118
	 WTBw9wfT1l3nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] xtensa: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <c484b749374ae3768e57f4e7148324c4a730bef2.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <c484b749374ae3768e57f4e7148324c4a730bef2.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:02:16 +0000
Message-Id: <20260902150216.CAA321F00A3A@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D13

