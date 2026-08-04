Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133F3C8C65
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853950; cv=none; b=JPcqiviQmMAmTUXbjJsyPTmThizvx37nV4BYlSxGtvcdOFsWz0AyQdzvLjvNasoO502GNRveQQXlXP9WFnWFMcPZvX//8Kk/BFC/Q8A3BfOfxNlK86vPW3/zw04i4mvoL977VKSPlhF64YeySY85xFCPAiMoH5RwR1JlO9x6E/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853950; c=relaxed/simple;
	bh=cVdVFAEMUKYajd9A2lsLnfUmwu2MYfCChVWhUYxl6YU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YkXRDhzMDiT3XxwIIAvjtHqE8kfx9DxVRGxRRd3Bw60ifaaLNbq850xWODWFw8EJHPBXo5R46iDZ/hZaz+LLhzJJm/DR2YeAOiMhGNou23xj6QBkZqG06dF3E0nA50wTixTvujLMFslYTjodBPmadeOzvYR0fcS32GDmiWBvuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBHvIJ6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBHvIJ6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E8D1F000E9;
	Tue,  4 Aug 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853937;
	bh=cVdVFAEMUKYajd9A2lsLnfUmwu2MYfCChVWhUYxl6YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nBHvIJ6HxEASelhvBj8T4nKuU9NvT3DaZUyoFLQaKuWrx6QIkIrEwUT5VGDRjMB2E
	 n6nJK+3puSqZrMIV9nwbcjWItm22phgq6VRbAhmiITQAqQtkfRhggujrp1CcveBA8F
	 DW+CI8VOTbyenvk3RkCU3jmxP2418FoW6qCoxKBpS4HjtAxLlSYhvQ2I+1x6ndw/2R
	 2YHooLVTwLuRO68rmvf2J89V4W4Z3uTCwPZQlnCJZvvDpmjUWrRSfoi4lO77JdlVby
	 3aWmqrQn0E7JjGSBNTomINKRBMseWBC6spKQIBA28nQUg3s6VMdm6MeswBtqtmtMyO
	 C+fFmOBSJAMwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/25] cachefiles,netfs: sunset ondemand mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, bpf@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260804100224.2748935-14-dhowells@redhat.com>
References: <20260804100224.2748935-1-dhowells@redhat.com>
 <20260804100224.2748935-14-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:32:16 +0000
Message-Id: <20260804143216.B5E8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `unbind_pincount` refcount logic and `cachefiles_get_unbind_pin=
count()` are obsolete and represent dead code that was not cleaned up.
--

--- Patch [13]: [PATCH v8 13/25] cachefiles,netfs: sunset ondemand mode ---
(Note: The format of this report is altered to a free-form summary due to r=
estrictions on quoting the original patch text.)

commit c6195bde7925bad759ef9b523809694f0463c1c2
Author: Gao Xiang <xiang@kernel.org>
Subject: cachefiles,netfs: sunset ondemand mode

This commit removes the fscache on-demand read mode since EROFS over fscache
is no longer used. It removes the ondemand.c file, the associated uapi head=
er,
and cleans up the daemon and interface code previously supporting this mode.

Link: https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=3D+kBCK2gGoq3Ptb8WkzCqS=
ogPgU_R3dQ@mail.gmail.com
Link: https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40re=
dhat.com
Link: https://sashiko.dev/#/patchset/20260722130218.78958-1-dhowells%40redh=
at.com

[Severity: Low]
With the removal of the on-demand read mode, it looks like the unbind_pinco=
unt
tracking in struct cachefiles_cache (defined in fs/cachefiles/internal.h) w=
as
left behind as dead code.=20

Because cachefiles_get_unbind_pincount() in fs/cachefiles/daemon.c is now
completely unused, and cachefiles_put_unbind_pincount() is only ever called
once per daemon lifecycle during release, is this atomic refcount still
necessary?=20

Could we completely remove unbind_pincount and its associated helper functi=
ons
to finish cleaning up the dead code left over from the ondemand mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804100224.2748=
935-1-dhowells@redhat.com?part=3D13
