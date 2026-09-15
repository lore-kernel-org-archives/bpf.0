Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80363BB4A
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431284; cv=none; b=e2hwCrKeT3zOk8kVch/XPYgck3IyUjIWKhM3O1QbsRm2Wf9VXGfL2/wL/x7u66668uHtCmxy3Si45/aC9za0kn5bwLfe8+x5hmR6dREraWyZU/4CaahYZPXVw2Q5S06jMnFTslqGEPXiOvUGWMxedMySRiu0G3YpSPx4ApqtkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431284; c=relaxed/simple;
	bh=ALZhFssWV/Q2TLE/6QhuCoVqQRYEkkrxBl8CwM9EUtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yy36WpJpiGa6xU6RC7m5yq9LVzhDHAWRESuuMT4iuMZDLgIygPbWTo3t7SdV2FzY2x4S0bJXhITo+oQGTuZWrDZrNMPN20fGuzIYb2pvOdTlflMSMmZu0sQ+PE72sUS6vtQ52W7xStAUxBPB/uuCdaS2B/4muf0D3tmMFf4lcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJdETjG7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJdETjG7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd664da0f5so14893865ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789431283; x=1790036083; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ALZhFssWV/Q2TLE/6QhuCoVqQRYEkkrxBl8CwM9EUtI=;
        b=QJdETjG7EVbrsUzHbYfxzpFimOqA690B7+CuqQsQUEj9qshoROZ+9AxTF0ViBL66wc
         8CjdR4EVKSHTcuMIex1pE8Ac7/o7p3Y6k0RKp5/Wsg/q7zy5ooXDrkE66fCN9ThHc0d1
         cCIsOMaEqm6q58Ui4qxxAsAKdpqJM+n/wVS0/YEMajWgVpP/Uh5hwHZ70raReG+U6egi
         Pjl9tlGyZjWJIv9LYts9LR3cGxC8pa3riKX+K+6Fq3ubhVLu/d/ltsplIYM7tAH8Fhw9
         bwczfFumGA1trVcLz3I3HWodCh6gt5cJgrK7IdM/yQMnkvqlKPlNsiGbR1zh/WWCNrVq
         aojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789431283; x=1790036083;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALZhFssWV/Q2TLE/6QhuCoVqQRYEkkrxBl8CwM9EUtI=;
        b=DYz5P1EBIZoXuhYGNXaqiD7AA/J40J3/hll0B/bCl3YbPod/A8QbIAWQpPMgSDJznV
         wijbC8DWtF8EP/2fZ8vjHZAQszH6qAqxBDSgrud2Ub0xDVoW6jgVs9D7BPY8YY0eAGkR
         KOnlv/UP0/PKLkYk7hcp4c3Q8g3WhTHGQZnkaT9Tz3XEnT+R4ocQADVqL1cRtPgB/hNW
         vvcf1rGyarjrltFGq7Gl2xNObqiY4EoPPImhlHfcGbCzI+BLwUzODsqycumXrK2+vtdN
         /7WS6HnPmQR79xN7FCOfRN9U2iTLc06sJYLHn7QDnLGakNpIw3uH/FpeE9COtCSTgvSi
         X8dg==
X-Forwarded-Encrypted: i=1; AKwUvBwa6auRxyWr35UvvWyayWESrON6Fa1/a1E2luvYeSoFtKZT2FwfgNul0rjhmgqNU5nPbSk=@vger.kernel.org
X-Gm-Message-State: AFuF++l2EYkZiHZ6FFbcH8c6I/pfTH14PCnzXgfhcPSlyKrp45GetqDn
	mSYznWKdmyABEQocYHPeZtlZsjZufA+9JQ+++GUtxk1Qk+niG8Kf/rT1
X-Gm-Gg: AYBFou01ArNpe2QOtrLribg5FIXcW2+TFMQnpSYKgL2irc7opDu7gedyCDS+y5nYBsd
	zNGi+vCGrMEINFFAucs3nn7o14Z9GlHvFQLZWVz3PzEvAj9BcqnsO4pC2BY3i8fDUM006rJKdQJ
	qRGlmu5Dg+aRd8v5qV2IUhofaOzwYy2UwTnP9uDNeYMei9bNeqsX6dD0QUeSDARdGCNXkQD1TIh
	BTVzxpQxB7M2nOjE7MpmQUGBTopgKhGOi/FHPBe5Uqupf1nYMWYya7e5j++4LAEEHqG80PCLno0
	EM0Sr8ZnzDNS4wG1qmgT9mGmmdQA7URl0G5KE1I3h9hOF+BhqLFpt/io/35G/xH/WguSEbhcEJq
	VCOjPZfW7ZzaEyeoFOXBvTcCqzzlgR7j/aNVU2RREhb3xjuB+A1+K0Nn5/wBmKdXTaGzWlOfEb6
	RKlO4N+uSla6kxrJy6ikX28N6O0fDLVzhWdPgRIJe/22PsZz2RKjluUVytFH3pQLJ1ld1AmlrIl
	4C8kEkvJ0ry26ovpBJNCIv0EEw=
X-Received: by 2002:a17:90b:3850:b0:39d:fcee:8d10 with SMTP id 98e67ed59e1d1-39dfcee8d72mr3406262a91.16.1789431282806;
        Mon, 14 Sep 2026 17:14:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd0baaasm1647896a91.9.2026.09.14.17.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 17:14:42 -0700 (PDT)
Message-ID: <588069c84c51c05461252c76824d0c6c19e83493.camel@gmail.com>
Subject: Re: [PATCH bpf v2 05/11] bpf: Don't remove indirect jump targets in
 the nop removal pass
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org, Sandipan Roy <saroy@redhat.com>, James Burton
	 <jamesburton@meta.com>
Date: Mon, 14 Sep 2026 17:14:39 -0700
In-Reply-To: <20260914170326.249953-6-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-6-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 19:03 +0200, Daniel Borkmann wrote:
> bpf_opt_remove_nops() drops every ja +0 and may_goto +0 unconditionally.
> A gotox target may itself be such a transparent nop: it is a verified
> entry of an insn array jump table that is reachable at run time through
> the indirect jump. bpf_insn_array_adjust_after_remove() marks it as
> INSN_DELETED instead, and bpf_insn_array_ready() skips INSN_DELETED
> entries, so the program loads with a hole in its jump table. The x86
> JIT, for example, lowers gotox to a raw indirect jump, so executing
> that index jumps to the zeroed ips[] slot, that is, to address 0.
> Fix by keeping an indirect jump target in place.
>=20
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Reported-by: Sandipan Roy <saroy@redhat.com>
> Reported-by: James Burton <jamesburton@meta.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
