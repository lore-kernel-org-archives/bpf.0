Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006853B71DC
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545581; cv=none; b=mqoZimkmtfoHrfUO+V0TQA+not1MNIX/XheXfMLuf7lI4yevgvq/kJE0Sdz+7q93y49iJ05U5KCHQ+ziEFD3CYQ2Vb9RBiW5ZfYdbGk5+D52I3R10VDCfRwZTZk+Wl07DYqAMtNtefPsTmZWKygXTcLryaOyyiajVVCWgoNr24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545581; c=relaxed/simple;
	bh=GxoaDTr+2L9Rr5BThyxA4jpbAZBQd9uQS9YZPr3mDTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scCImWqRvtpeFxjwwIWnMlJNerBBIjkYbOLmvTgHxBMUqLB2GJg5NUQomrYWYLpyRSTd0+MR68oEU5bZ/83EVGk7q5JeECENtjT0V0udgLan36WDAuMgC0FoP4eEVrtcFPRldraDNYS8OQ+PCJZfsY+4SL/UqZA3vepRoOp5l78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ1WkQ9Q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ1WkQ9Q"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1585323f8f.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788545578; x=1789150378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JdDgoY8pXDM5+WRhKmXbZ8wB0r+I4703My4JOpLig/0=;
        b=LQ1WkQ9QqCPDy2cT1/Gr/YxK3O2xjdOKZ22zJ2SFpZEBCitJVmISLzllbZ2U7pgJA5
         NzFjdeMjcYJ+3rrye2VpsQv3MeNIdOA0bZohWbT+F3ZDnPUPf9lz9h1lJKObsaPJ1Rt2
         SDXHX4BvkX+kqDRpqDasX+IqCS2h2PAovHm58+MZo99kaQ/JB86B4El83cRqxEDyVrSP
         fGhcfBGq4UMoRpkcs8F0N05vcI8ItpWqeELQpeHt0WIHRDaNYR8tEKQ3a7NmBw+O9c7h
         cNxvNeKHs+iy5kgh2qy0TXSijj2LNyFYxoGhIudyQaLQ0blbtMEatQCHFh0hcvJn6mVv
         WFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545578; x=1789150378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JdDgoY8pXDM5+WRhKmXbZ8wB0r+I4703My4JOpLig/0=;
        b=C4748IwiQLtxJa2XtcE3zsBrRM/iurUUHJ5NlOVztOeL0J4hcpdwy8rfyDAyiRnPMu
         tD3N73ZzS+4v187A2gen9JZf81lXZ2+xlxRvbQOrlnCZ9dPCyf9BzaYznsVaP2GFOcG0
         wY85vnG09VgxUVSjgIBl+1YNYxUWMohjoVOZM0EzOYvs9ZdsicyfKHmZ1EsDPM3wbyUM
         2kPHks2XpJTB0Gwkgl6Iw5x0+AID1IZAGpLtCL7hY9gfftHHxv30c9S9nHnf86rk66En
         e0m6kiVpxiYtwcgVebtbPtIRZNu53fsCLwNG0/o+rzXtBx3LenBdhdEGTL8BVdOsI1FC
         H7pQ==
X-Gm-Message-State: AFuF++kVsvClzaSscoGeQjImYGdvhqk+dAXvitp7Nb0j+HDcnbtF+XBj
	B7gGI5CqrnCNXHWyDzYntkr7qHJW8fGIDi8bhZ/3tJ8KEDddCSK/N1GcF5P+t52P
X-Gm-Gg: AYBFou3+F1hOoF07jkhVkWyjTIsR5o1HhQux66x0DYtOAwX+L6gmshK2k4kVfbIfCdD
	2XmMEoj+Gc0lgtm9jqdvd5kCUn0motNl6YPykhbojMc9bHoo5w0k5VkMiPaKw0QhPQpiT+3MNv7
	nDb1/5OEjxS1TjFFiW6bZErsxTUM8xTOMbix+1Gztx8OoTM8ZAqsBwK1Hi/AW2Ghq4P22ZIpQ2D
	AUPmZfcB1CDTSq6pE77AgRqfoTccsEbZlgcu6cBHkbj1KSYn7A0fhBM0Iz5t3r4dLnEVW0DAwAg
	ZsvNQrPtJHO+VWVQ2y2AXBAHCFeFNhV1V1sxlhJJ8h0LfS5bPVDdB/Vr5AJYIrLRElQ1iyA4eVh
	j0LeDngZkFHABpwtqhEdNiHTB8u+W4iG0yiVzXOTIpspLfpysocaTJhV3xrqlLj/+oFKMW6EIBP
	zde8kSCJkskGNJDc0DT5WfQNo521gbqwrA4HIGLAmZUMZ2Q6kfyxK+0mFKxgS4ugeEI4OOjV9ES
	qNB+PdRzpfZFOQ=
X-Received: by 2002:a05:6000:26d3:b0:47f:eac2:6f55 with SMTP id ffacd0b85a97d-4858708fab5mr15137202f8f.19.1788545578083;
        Fri, 04 Sep 2026 11:12:58 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:bc7:8550:3077:285c:12b2:33c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm7830734f8f.23.2026.09.04.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:12:57 -0700 (PDT)
Date: Fri, 4 Sep 2026 20:12:55 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf] libbpf: fix log level propagation for light skeleton
 loaders
Message-ID: <apsKJ65v7tOw7CWT@gmail.com>
References: <20260904171601.336613-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904171601.336613-1-mahe.tardy@gmail.com>

On Fri, Sep 04, 2026 at 05:16:01PM +0000, Mahe Tardy wrote:
> bpftool's -d option is documented to enable bpf_trace_printk() messages
> from the generated syscall loader when used with -L as specified in
> commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
> and "gen skeleton" command.")
> 
> However commit b59e4ce8bcaa ("bpftool: Switch bpf_object__load_xattr()
> to bpf_object__load()") changed bpftool to use bpf_object__load() which
> call the internal bpf_object_load with extra_log_level to 0 instead of
> bpf_object__load_xattr with the user request log_level.
> 
> All the plumbing was still there to generate the bpf_trace_printk()
> instructions from the generator but was now unreachable because
> bpf_gen__init() was called with extra_log_level to 0, leaving
> gen->log_level at 0.
> 
> This uses the obj->log_level field introduced in commit e0e3ea888c69
> ("libbpf: Allow passing user log setting through bpf_object_open_opts")
> set from reading verifier_logs in do_skeleton(). This preserves both
> object-level and explicit load-time logging settings.
> 
> Fixes: b59e4ce8bcaa ("bpftool: Switch bpf_object__load_xattr() to bpf_object__load()")
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..395c4dcb54de 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9144,7 +9144,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  	 * permit cross-endian creation of "light skeleton".
>  	 */
>  	if (obj->gen_loader) {
> -		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
> +		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
> +			      obj->nr_programs, obj->nr_maps);
>  	} else if (!is_native_endianness(obj)) {
>  		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
>  		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> --
> 2.34.1

I realized after sending that writing a regression test wouldn't be too
complicated since we can check for missing instructions in the loader
program given some user input. Tell me if that would be useful or not
for such a small fix.

> 
