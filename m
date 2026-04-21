Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF137E2F6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761688; cv=none; b=Acc370IhzQ2tMCVmENhkaQX+brW3V15CR2+jz9BWQxGROEObLOOYqEffiE4LrD+UF7qYbVZf+xyyOki5aSLmZ4wmf0rIBmZSYjLPpUzgxqU5Vbdjx1ADgXUln2aNXTMpdC6ttSuPJUojxnpcidqIPJSYz/rK772zdm3gEmhifc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761688; c=relaxed/simple;
	bh=3Rm0j0jpOm7x8JB70ao9c9n0Rm6yAuqSFxiPxK37h98=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haybynEqiHAB+v2SNojZy/RIpWIlZjVz1FnQ1KbbzTrL35AaIz7u5vYjDeQOtjhQp1h+nSj1By0N7RyFFAG5o+KKjKet+ANLS8oOPmUsTbVvw5QnPL3BHIF1LaL/8rAWDCQTQIRYA+T5r6OvtUDSLx0HmwrZaAaxg6XFWCeBz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzIBhvCz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzIBhvCz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso1862837f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761680; x=1777366480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEBDw/CHdgROimN+5rHeTkzLPXnxJmB91Vu74p3MB2g=;
        b=LzIBhvCzNXEH6KjJgVHGWXX2Te9CLdOCeNkEdJ7U/93fLVAa6beKynxzE9ts5/kY31
         zhKkauGux7nAe3RmZfwfl40J3aLbkzmofznSzO7y8SOiZFAIt9w3CtUHtKDtt8Fsxyn8
         E4Yvsx0wh+sXAcGIUEOpwh5gZFTdB5tGvm2or1cV7ogxe1QdRiB2BkHl+vxpFJkAa3dk
         6W6XiEgugPoqvq3ZZP6vDwsJSAth1ygjfATTBcow2BTFnY0HWfaRHfrV2bPnBA81pHvf
         a6V/4ZswGpHGJvVDYF7GqtWXL5srN4hTLUgitjUN167V5VNeVIktMElAWQzO1B9tYKVq
         E1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761680; x=1777366480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEBDw/CHdgROimN+5rHeTkzLPXnxJmB91Vu74p3MB2g=;
        b=h6fVTJ5WfAh3+QyTyQyu11CqKoE3nQOAlHRIT2AO3IKmqXtGaWe3DZ1CP8k9msy4Ae
         3ejIHFNYtFnw2rJ9xW/mFGGth8/j06BJ/lFgvYSzq1ntZz4Fm6daiicTINSRPyeAI+El
         pY6xHD2LdvpwhGRDxEpYEFJN9J0heMhewdjAUda/7AjZ0OLv9K4e9FQKOzNX5T8BgzVQ
         B9Tomc7SVIuEOdUwNP1+q/AwMlDeUJs/lfaDarwcBGX1D+o0joiFnpEc+cXTXyUMU5vB
         PX6HrUOlhUpRtiKYDogz0Sqt9B1xNE/pWosDp5/1iHm7rbB702VmW7oG1RPtlRr4DniY
         tvCg==
X-Forwarded-Encrypted: i=1; AFNElJ8YHBOPgZb0P8uMPE2vbtl2N7EjSShZNPtGXZIOyVF9osEK/DzUhNnxFv/hOED+ghHVlEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhozfWSGIGOOuiy70r5ZnCnKwhUo0tTEOa7mqqGAgy9GUngWx
	0z6ACDQtWpPsmOWNmgBYjjG84cwbyqJl11OLCoqs10PvEv/PRLO+Mh2D
X-Gm-Gg: AeBDiesFZiH/U1GRryydpfQcEDJxeTO2rQfYunyxpXtYTPvXcpoI3ZIyuJaMXiHIcPP
	6ON6bjaAHIG1Id2vHiYL/+QruNJiftP0/cM/HuQf5v4lXHL5mTHz3u5n/qZTpv3eo0ivCDL/kyW
	2bLTLBeWKtPOOWQGFJ5vUieBefLTf8QVyZEk3+WALmnAaL0KrstVbW3yTqSy+cRJgpngjW3iway
	A+MHxGZG5yDwlEuYUL3TUFRNBGgbmOTazhvjvywbRKyXWTdPPnhT8RiqRtmTjEm/w8AmheLDa2U
	xaLPZXs+aN1qpnVNjaklUCFotOyohuwxp6iFxDTsiB7wREhoW3mzSpRrnIShSTghRqu4wKuMRLP
	Ya689vxW+F+8PJ/wKmiPbcITURKS5qLf2Dn1QpUU2S9dFP4ru1YN6q1njd3+JeAx5naI6EMjVsq
	XSiXFJWIk=
X-Received: by 2002:a5d:5889:0:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43fe3e0c7ebmr27454724f8f.41.1776761680216;
        Tue, 21 Apr 2026 01:54:40 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm35813045f8f.16.2026.04.21.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:54:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:54:37 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <aec7Ta9m8Q86N4l2@krava>
References: <20260417192502.194548-22-jolsa@kernel.org>
 <1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:10:22PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,256 @@
> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> > +	struct btf *btf, *vmlinux_btf = NULL;
> > +	__u32 nr, type_id, cnt = 0;
> > +	void *root = NULL;
> > +	__u32 *ids = NULL;
> > +	int i, err = 0;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return NULL;
> > +
> > +	if (mod) {
> > +		vmlinux_btf = btf;
> > +		btf = btf__load_module_btf(mod, vmlinux_btf);
> > +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> > +			btf__free(vmlinux_btf);
> > +			goto out;
> > +		}
> > +	}
> 
> [ ... ]
> 
> > +out:
> > +	tdestroy(root, tdestroy_free_nop);
> > +	btf__free(vmlinux_btf);
> > +	btf__free(btf);
> > +	return ids;
> > +}
> 
> Does this code double-free vmlinux_btf when btf__load_module_btf() fails?
> If btf__load_module_btf(mod, vmlinux_btf) fails, the error path at
> ASSERT_OK_PTR calls btf__free(vmlinux_btf) and then jumps to the out:
> label, which calls btf__free(vmlinux_btf) again on the same pointer.
> 
> The first free happens here:
> 
> 	if (mod) {
> 		vmlinux_btf = btf;
> 		btf = btf__load_module_btf(mod, vmlinux_btf);
> 		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> 			btf__free(vmlinux_btf);  <-- FIRST FREE
> 			goto out;
> 		}
> 	}
> 
> Then at the out: label:
> 
> out:
> 	tdestroy(root, tdestroy_free_nop);
> 	btf__free(vmlinux_btf);  <-- SECOND FREE
> 	btf__free(btf);
> 
> The btf__free() implementation in tools/lib/bpf/btf.c checks only
> IS_ERR_OR_NULL(btf) and does not guard against already-freed memory,
> so this would trigger a double-free that glibc would detect and abort.
> 
> In the current commit, get_ids() is only called with mod=NULL from
> test_link_api_ids(), so this path is latent. However, a subsequent commit
> (4dda98b9e4d0, "selftests/bpf: Add tracing multi skel/pattern/ids module
> attach tests") adds a caller get_ids(bpf_testmod_fentry_test, cnt,
> "bpf_testmod") that activates the buggy path.

yep, double free, will fix

jirka
