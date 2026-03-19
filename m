Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE837DEA7;
	Thu, 19 Mar 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943082; cv=none; b=H//nJGtc+i3KAfHk6SGQqNn5Hj647To91oTAoWtoGzQnLd8jy0Xl1pJM9CF9441hYEzhmVEKnrBbQ2b35Gq6+SKu8Q3ucAcvnzgGTKBzLX8qIb55kQ4630shD8py+7lxWxOTMv9Q0PJyGIOYfHnZFB+D3KegQQvkhUQhcHG0Ppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943082; c=relaxed/simple;
	bh=eZVsFu41f7EW+5iofFUYVXXLm/z15SzfvV5PinY5nWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptXtApeuBwt4SmkggwXEIUjig0Dewy9CUVXcR+7jcY/OE1JunUceP7GvpVAkEJoIuIbbq+pB+XCyLYIlgMaM9RcJxVjO5lKoWOP3xPu6Xj7blUcafMcFqmfEmRRM4rhe0Ds0eeKeE65ThL2pZZiBNDBQ+4kjf+cLJrjjSuuLeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWMB0MWv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWMB0MWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773943081; x=1805479081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eZVsFu41f7EW+5iofFUYVXXLm/z15SzfvV5PinY5nWM=;
  b=OWMB0MWvTYyr8l6aU/0eWytqf3MlZNR+51VDDW2bsQxo7eL9qgIqMNXh
   grcVWhzBSdTFpR8NrjQ204PTNf4cawtTOzXVIfeHd35wi/DcicuwToP8O
   TNYME8X9YpnWMFWsz5W2hskMLQ/yt7SSmMJ6gT2O8HRRLpVAUFRiT6fPT
   GAeQE//qxPjBaYMl7FLMpUvukI9sf6x7j8DP2+7RzK4NAAczor4/j6cef
   axGFbK9nSjCklHnZEJ5TcF8xCZtZ8WUOqfQ0z9PR4fdTFKxH/kdzyC3ng
   NCs7++Z+Fko8nvIGkRN4qJIQN/z2MASEK/sTPqyU4Yl+1vbueIdgrhtRZ
   Q==;
X-CSE-ConnectionGUID: 9fYvC+QETy6uwFOlmUsUbg==
X-CSE-MsgGUID: +0XYh0y+RZuAgz0XwbPB0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74202504"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74202504"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:58:00 -0700
X-CSE-ConnectionGUID: sYHF8pOnQBuZgqulXcEjsQ==
X-CSE-MsgGUID: zbDeFkTUT5idDvwlfyMmZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223062364"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:57:59 -0700
Date: Thu, 19 Mar 2026 10:57:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: x86@kernel.org, nik.borisov@suse.com, hpa@zytor.com,
	jpoimboe@kernel.org, david.kaplan@amd.com, seanjc@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, jolsa@kernel.org, davem@davemloft.net,
	david.laight.linux@gmail.com, luto@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dsahern@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	pbonzini@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, asit.k.mallick@intel.com, tao1.zhang@intel.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v7 10/10] x86/vmscape: Add cmdline vmscape=on to override
 attack vector controls
Message-ID: <20260319175753.ocv7mv5hogscptvk@desk>
References: <20260319-vmscape-bhb-v7-10-b76a777a98af@linux.intel.com>
 <a0134d85926936821c00147b9602b4f977519556e163ebd59dee2307c7618fb1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0134d85926936821c00147b9602b4f977519556e163ebd59dee2307c7618fb1@mail.kernel.org>

On Thu, Mar 19, 2026 at 04:40:21PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -8375,9 +8375,11 @@
> >
> >  			off		- disable the mitigation
> >  			ibpb		- use Indirect Branch Prediction Barrier
> > -					  (IBPB) mitigation (default)
> > +					  (IBPB) mitigation
> >  			force		- force vulnerability detection even on
> >  					  unaffected processors
> > +			on		- (default) selects IBPB or BHB clear
> > +					  mitigation based on CPU
> 
> Is the "(default)" label accurate here?  The code default is
> VMSCAPE_MITIGATION_AUTO, not VMSCAPE_MITIGATION_ON:
> 
>     static enum vmscape_mitigations vmscape_mitigation __ro_after_init =
>         IS_ENABLED(CONFIG_MITIGATION_VMSCAPE) ?
>             VMSCAPE_MITIGATION_AUTO : VMSCAPE_MITIGATION_NONE;
> 
> In vmscape_select_mitigation(), AUTO and ON take the same switch
> path for selecting between BHB clear and IBPB.  But AUTO goes
> through this check first:
> 
>     if ((vmscape_mitigation == VMSCAPE_MITIGATION_AUTO) &&
>         !should_mitigate_vuln(X86_BUG_VMSCAPE))
>         vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
> 
> ON skips that check, which is the whole point of this commit per
> the subject line ("override attack vector controls").
> 
> A sysadmin reading "on (default)" would conclude that not passing
> any option gives the same behavior as vmscape=on, but the actual
> default respects attack vector controls while vmscape=on overrides
> them.

Thats a valid point. Updating the documentation as below:

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1068569be5cf..98204d464477 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8381,8 +8381,10 @@ Kernel parameters
 					  (IBPB) mitigation
 			force		- force vulnerability detection even on
 					  unaffected processors
-			on		- (default) selects IBPB or BHB clear
+			auto		- (default) use IBPB or BHB clear
 					  mitigation based on CPU
+			on		- same as "auto", but override attack
+					  vector control
 
 	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
