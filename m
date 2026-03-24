Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED013B6BF3;
	Tue, 24 Mar 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379373; cv=none; b=ZfwkkzRGJ0eBhj8sAARoUHi8bcOioQHiRMCHi5NNZLHZaLcIO8dxR2n9UwZDVV6W+8EETyDVlL/8uP6lIIDlL1ZY8GFns5jHYmSy2nVuRjiIE+QrieLPf85wtGpg/QdMeD0Oe37brWzqvdPC7B6F3RHDKCQcwIGM48/4D35B0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379373; c=relaxed/simple;
	bh=xOEwiz0qRG3DaZGsPLHHyoPEIJexNoCMzyHC38ks2uk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ua/kjPXy4Xl8oWT6iL5febjXYrJuaByrDYGrTLjo/Kfg+9v6m58xRDY0Q0Nqty3ySarMD9tL9LXUKyHRfo5VJAM9AnbzY1trVEYyGRMjhpOwwVNSdBFY6gyQwLpRKt/A8LaaOzHiF+viRKqACOci5uLqhWkThgfgV5eOWrlulxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJoQNi48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJoQNi48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DEC19424;
	Tue, 24 Mar 2026 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379372;
	bh=xOEwiz0qRG3DaZGsPLHHyoPEIJexNoCMzyHC38ks2uk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FJoQNi48GOmo9oKCJnQBVvAQgwqVK0RL6kXZbpgxpHvgDufEYg2V6RZqxv81C6mtz
	 GgHxp8rHJouaF8jfdinFelm181DcNisWg6S46aOxtRo+Ul11EuLxGsA31S99iJvXS2
	 0wBtCB3D99XhqMmw35JboK86iaIuOGlQ/d07p97aF2f9AuDR8xzrD/pBhGyODmmeEF
	 VJ0lkPNjq7CXIT4t3GWcWxxH5OLt1IQgsn04iXLboTvO2Oih1YMHBQ1XiqKM5Pz5EV
	 hwFOhlepNHNOm/mSmYVcNu82nWkFz7U+RasX82AWU0FEfAXQ7zdAUStvd047o1XLvg
	 p5m3T5JuLIYrQ==
Content-Type: multipart/mixed; boundary="===============6618981801720707195=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>
In-Reply-To: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
References: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
Subject: Re: [PATCH v8 07/10] x86/vmscape: Use static_call() for predictor flush
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 19:09:31 +0000 (UTC)

--===============6618981801720707195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dbe104df339b8..b4d529dd6d305 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -503,7 +503,7 @@
>  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
> -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
> +/* Free */
>  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */

Should the corresponding entry in
tools/arch/x86/include/asm/cpufeatures.h also be updated to match?
It still has:

#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14)

tools/perf/check-headers.sh checks this file for sync with the main
header.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23506000396
--===============6618981801720707195==--
