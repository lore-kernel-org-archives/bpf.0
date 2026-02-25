Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC92F1FF4;
	Wed, 25 Feb 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043773; cv=none; b=dlkt9OJmzro2fQDuNNU/Nyn2OYbn1Dvrgrq76PYG/zQFCH9i+AoSuxIagnY/hXUxyweYWqP7a7R8T2Bp7HUYmohT2iGaEvk49vBC56UDE21Utz6z9BeCJAQUr6mqCGggGPvxfTuNDQTVBIBd7BEl4I8GpP3A1ihy33vh25HmFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043773; c=relaxed/simple;
	bh=Ws5y1Ig8IHrFM81Tixi0BIH/EStK4iuy3pyrDdPVWVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9skB1RD4VckPPk4a+08M1JJEjB1NMPgbE48rMecb21CAVsoK3Tu1MHhODs9FCRWXy31GPT6G3x9eR3pBwa/Q80ClUU4uoS8JrRVwjwJl+QdYD1bAIlhGsV3VRqcYplk13zwzuti8ryj+QX6bnOyDMMlJJV13dv88OiY7/ieop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKvQbUnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKvQbUnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A26EC116D0;
	Wed, 25 Feb 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043773;
	bh=Ws5y1Ig8IHrFM81Tixi0BIH/EStK4iuy3pyrDdPVWVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKvQbUnwARnjojuIOvjRyEftfml/ydjTraoKoWo+AYuxxHGpxra3AAR0e6j52JAHF
	 ZEMku1brfy5o3HSejWJ7HT0DLxiVQP7fHCUeQB/Ma23PJTxJD+XHeJ+3Ie3GlxV20m
	 hYDASD356XMIK22/OR4iPL1eB87KRJpXyMBPNVMquAlLDyleBmqkKGjIBkY4j0zoNy
	 KSMYqa1MFGsVR4jIl02b4YNQtkEqQVLyINWcTp0DpKnf4ETeSMjB09LaX2h7/6/gU4
	 R/gU9i1+GNuZkx4Xc80H06O1AYzGLtp/V/4CerTv292GagizuE8ZQJ58Fc/0Waca0B
	 x+vRJHqjUSjDA==
Date: Wed, 25 Feb 2026 18:22:46 +0000
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
Message-ID: <aZ899voAQEi_QvWy@willie-the-truck>
References: <20260224093128.1926610-1-tabba@google.com>
 <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
 <CA+EHjTyXWqnr4Cu_cZyxDCVNCxto9pJN0WS18S_ri824oQhwug@mail.gmail.com>
 <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com>
 <aZ81zpP6ooG_19cI@willie-the-truck>
 <CA+EHjTxxqr1fTfDrFwpij+92BEATbYTWmOKqtDeo5jgfqqCsFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxxqr1fTfDrFwpij+92BEATbYTWmOKqtDeo5jgfqqCsFg@mail.gmail.com>

On Wed, Feb 25, 2026 at 05:53:18PM +0000, Fuad Tabba wrote:
> On Wed, 25 Feb 2026 at 17:48, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Feb 25, 2026 at 05:46:52PM +0800, Xu Kuohai wrote:
> > > Interesting, I think the plt target should be 64-bit aligned to ensure
> > > atomic reading on arm64. It can be updated concurrently by WRITE_ONCE
> > > in the bpf_arch_text_poke function while the ldr instruction in the plt is
> > > executed. If it is not aligned correctly, the ldr may read a half-old
> > > half-new value, causing the plt to jump to an invalid destination.
> >
> > Thanks for pointing that out; I hadn't realised that we patched live
> > PLTs!
> >
> > > To avoid over-aligning the entire buffer, how about fixing the padding
> > > method in build_plt to just make the plt target aligned correctly?
> >
> > Makes sense to me.
> 
> As I noted in my reply to Xu, and keeping in mind that this is very
> new to me (so take it with a huge pinch of salt), I don't think this
> is correct, but that my original patch is probably the best fix:

[...]

> > I'm not sure about this. If my reading of the code is correct, during
> > the first JIT pass, ctx->image is NULL. The current padding logic in
> > build_plt() looks like this:
> >
> >         /* make sure target is 64-bit aligned */
> >         if ((ctx->idx + PLT_TARGET_OFFSET / AARCH64_INSN_SIZE) % 2)
> >             emit(A64_NOP, ctx);

Aha, so this handles the case where we have an odd number of instructions
and need to chuck out a NOP to align the PLT target. So, yes, I agree
that aligning the entire region to 8 bytes seems to be the expected
behaviour, otherwise that NOP could actually result in a misaligned
address!

Will
