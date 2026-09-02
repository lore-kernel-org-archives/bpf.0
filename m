Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501C477E38;
	Wed,  2 Sep 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361636; cv=none; b=PSDJhav6HO0Tu1c8loBQ2up2oai8mZtUJS+INoEqzCcMCt0aNuA/IfJH+ROBnlyTusDdhYFYdKKSVHUQTEJNTrRJ+iM5jmPaomlcIle2704etNoZF1FTpYJZhtxDLwtAUKEDjcBGEXUSXYv4zzZxxP9CAVfnlKZ9oGAuK4C0aA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361636; c=relaxed/simple;
	bh=DUWK3OrXE6PPIYm0awoqA4/cmybr68GEwq9/0ePspNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3rL4z998IgAjQUyzVj84zPvKirRVfjWeA6jLVmaO67V6svqKXdhNehelyi/a7GSEcoHqAxazen+xRnzRVu8CMJqhvq9pAHx4uwHuKAqc5IYBG0xMhvNoN4sJTNrgtTiVnLEsaWmIlkXwVU2UstP0tDOX7OltyBprBLi+vY3PrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0skHsMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0skHsMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1121F000E9;
	Wed,  2 Sep 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361634;
	bh=DUWK3OrXE6PPIYm0awoqA4/cmybr68GEwq9/0ePspNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0skHsMpNwcqoi9kmIC3inhTCsNb4geahZnPxWEbNJChGLd7DiOnG9XDWfynZ7zR2
	 dolWOiOgJv5Qsy8h4kdk94tRGuokUr7rPsrVOh5kX9JKI9cLAqRFAUIIFDj6Iz6X0P
	 98+TYkrSlowFTqM2nsvm5c3g8U83HAcTF/RMKnIVei+n2167phFSJQfurgwS0SCoUe
	 OGMkTZnUmAT8FjywPeqcuee3JEykzkPZCtDGNltv0F6m0Xi1w4x5CJksfx/3RmXH/d
	 oW/oiBvpWd55VeIKG5NeWyaIwil28yUkeJNVKEsJvbFKKshWlAtWIhczZ9PU6hHLnL
	 WUR7zinUVPcmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] um: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <db5c792376cd0da372e2a6a7f2da3dcce97d151b.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <db5c792376cd0da372e2a6a7f2da3dcce97d151b.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:07:14 +0000
Message-Id: <20260902150714.9C1121F000E9@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D12

