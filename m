Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F43EF0AC;
	Thu, 19 Mar 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938422; cv=none; b=uAQJSzosJj18jL0B+S4p8YS7nV+WAjQ2TH+N4Sgu8oqLsICilD9N4+A4n6HdQYxWahDYoq+ylGAJTD6bqwaB9k4rNXUiw6tXtfgVYwGCX48JhSd7fIUrcqmvwjFV/8xYZ6wjpMQ3dz4uz22GFvL5iGx/vWML/9EvSUE3E5bQhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938422; c=relaxed/simple;
	bh=qdSHlS15YIrrYlKFILuH3C5YTTS41s9xNZ21/Pbj60E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c7zTWYGSZW3C/kj3HduppvLmh416tbEhTOnOpBMBaadjD+M1G1V4em936YqITDBLLArApBmsr7abAbUxH/Qji99u+x1a0jMxygIA2CodPmdK3IJCUBUEl1dSbxkp8YbsM64NA0mzv1w5UP7WP85PfarvIHyMRgXHQaJndFFc5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g80do7cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g80do7cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1E6C19425;
	Thu, 19 Mar 2026 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938422;
	bh=qdSHlS15YIrrYlKFILuH3C5YTTS41s9xNZ21/Pbj60E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g80do7cc2w63gJseXEe4T/85gebLSO3Hmp2yZL3egt+lTDYqfUNU4qlI0WQd6QHSQ
	 FHcHAbbxB9ruLGC3eFqZAnxUwBMzLdtZRCW6JEdLa8Skf+mVY+MgsUul0gYkVOMvot
	 rGG2XoMQuysCJjJvmyQjTLje+aCdIB64HSQ4BCQjZ7QoDEhZfaZcQV03WZkWdy7hkG
	 Lq108TcTKenwqaHzgfIIf+olkLDOHPbqT2p4xViRoUVWrv7keNgn/x1bp/qENWXxBv
	 trb31M2KyfzqdAvpd29rJZ8E7TmX4vQWINb3KG1u05pJVRSbI0knydA+0DW+feHNje
	 bxAlgKm5Dh9jg==
Content-Type: multipart/mixed; boundary="===============8015506610791822796=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0134d85926936821c00147b9602b4f977519556e163ebd59dee2307c7618fb1@mail.kernel.org>
In-Reply-To: <20260319-vmscape-bhb-v7-10-b76a777a98af@linux.intel.com>
References: <20260319-vmscape-bhb-v7-10-b76a777a98af@linux.intel.com>
Subject: Re: [PATCH v7 10/10] x86/vmscape: Add cmdline vmscape=on to override attack vector controls
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 19 Mar 2026 16:40:21 +0000 (UTC)

--===============8015506610791822796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8375,9 +8375,11 @@
>
>  			off		- disable the mitigation
>  			ibpb		- use Indirect Branch Prediction Barrier
> -					  (IBPB) mitigation (default)
> +					  (IBPB) mitigation
>  			force		- force vulnerability detection even on
>  					  unaffected processors
> +			on		- (default) selects IBPB or BHB clear
> +					  mitigation based on CPU

Is the "(default)" label accurate here?  The code default is
VMSCAPE_MITIGATION_AUTO, not VMSCAPE_MITIGATION_ON:

    static enum vmscape_mitigations vmscape_mitigation __ro_after_init =
        IS_ENABLED(CONFIG_MITIGATION_VMSCAPE) ?
            VMSCAPE_MITIGATION_AUTO : VMSCAPE_MITIGATION_NONE;

In vmscape_select_mitigation(), AUTO and ON take the same switch
path for selecting between BHB clear and IBPB.  But AUTO goes
through this check first:

    if ((vmscape_mitigation == VMSCAPE_MITIGATION_AUTO) &&
        !should_mitigate_vuln(X86_BUG_VMSCAPE))
        vmscape_mitigation = VMSCAPE_MITIGATION_NONE;

ON skips that check, which is the whole point of this commit per
the subject line ("override attack vector controls").

A sysadmin reading "on (default)" would conclude that not passing
any option gives the same behavior as vmscape=on, but the actual
default respects attack vector controls while vmscape=on overrides
them.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23303796353
--===============8015506610791822796==--
