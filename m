Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE33644CB;
	Thu, 15 Oct 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080249; cv=none; b=N9S+6+Q52yUYPTNf7YG/D/O1pG0BtNksbOrAtJgtho4z9U5X+7b6baH8t8SghahKfGPJA0xl0PoET7Z1U//xP/TYJcYGilhon+25VMRZY85NH6MV4+UsLu9i62G89bHSeRMF1jJ+EVLhkh8UV5AD3fq5gXw0mQeIX0+0QsD6R98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080249; c=relaxed/simple;
	bh=JXM+VqSUBfb1UKfsMN68G3v6uX6sD69SXf+u/Pdtfyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Om1HRmnmTZmbYzAVlr6JBAaYcJgipFAkqXU24TpUSKPC/O4rQ0o6wBfGULrSvm93q1vrm0Uiyvsb1P0wWQgZORnrD7cxAEqDr0TSfnopMrws46+O3IUy77ST3WjEziwv7df8621TmCyaduVz+Ke8MTjlH560OXZMrhLV/FipoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9KMCfUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9KMCfUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEAD1F000C4;
	Thu, 15 Oct 2026 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080236;
	bh=JXM+VqSUBfb1UKfsMN68G3v6uX6sD69SXf+u/Pdtfyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=V9KMCfUCZ6F0KoeujJEbYGuemhvcYXxbk2AfOnLo5wI0mNbzulReLYIal8HpwIAVN
	 a5anXuey+odjFkiLbgli8Gj7rxk6MuYpOrFfTJOQXQifSJ6LXwz1Ml0mZGtFW6JK2z
	 qJXm2B0Mj0eHUD6Lm+cSmUFpCPUVoOANlMQUZV7YzQXcWKWwek/J/EOvLFdGTUAUvu
	 Usa2Ibs09ak2XJlCFVUwRKt2ZTq/5CmplNFjIt3EoMVd1dNE1Iar10ivfYZCa6rXs3
	 7xPI0AZtI1j9LmMN/bBU0LVoVIcD6ffBO1Uhr4RvjYngfOQog86DlcWpo+AjLSxsOj
	 sknNGTUByScqg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode
 to xskxceiver
In-Reply-To: <atCxD0EJHCRBR+pI@boxer>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-12-maciej.fijalkowski@intel.com>
 <87tsmn5mg4.fsf@all.your.base.are.belong.to.us> <atCxD0EJHCRBR+pI@boxer>
Date: Thu, 15 Oct 2026 18:03:53 +0200
Message-ID: <87fqy754t2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

>> Also, we need IPv6 support here in addition to IPv4. You can't assume
>> that the DUT is onlink or IPv4.
>
> Is that currently a show-stopper? That is another left-over from old
> architecture where data path was rather on a local and isolated
> environment... /me finding excuses ;)

People still run that legacy IP protocol? :-P

More seriously -- my homelab, and our internal labs are v6 only...
