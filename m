Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B33E8323
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186771; cv=none; b=IxIytIkOamVVTDeQT+gbLt22G8FOk8LSKzMYVWEb98gidVl5e3qd/dQCpuFBmfDkLyUhlmuhpVZ6ZrM/Q55MSPpFhxPJ0r0fbdN6y/1vF5vX798XPNYabN6iszpp/LEw38XtcFj+WFNhwkvwQsSTr2g/cEC+8DbI1fU4UB0tPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186771; c=relaxed/simple;
	bh=i2XkLeOAuP6yRudyOpQxOo6nw7+tJ/QuA4/JdG/MHLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHRuBhA1AoYAXasbRY7FSemv9Kk1495VsmdL7wLG8FYdaLhVRZRZUVSAkPxOg6eAM6Q5sVqBOhle0ZY3Q9l/dyggc58SkmmXRlOEvLHih8PvZ38X4DmqvwVclUnf/dA96QybN/mnvUjKfVXIN2JiO8n3DYiQOtd4Mx4iTsXjsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnn+BDN6; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnn+BDN6"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c112aaaf04so848616b6e.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790186769; x=1790791569; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DVBitp2ypb5rk+Duv9E+85B2/ZBqaQtfqUeJKLPpBlA=;
        b=Rnn+BDN6aP0KQBGO6WKtQvfWPk6R7v3Gs2syX/YQ3MoLooNPUbzGm/UfuSGLTdZw3S
         jU/qjfB1D5M6KdQUFdfELvZZUFlpneAvavxEBq/Yy7or7Yds6RoM+lMAdVXfHT6ZdONG
         Yuy+pNPOEe7OqiPUWiB2xeUjkdJBiWVCdRvWs2Twri5BwKZ+mhINGISV+y4OwgcElkUF
         aPh9Qnb+gYSLrzfSygk1C3a65+QeFAd+QtbDp3z+paVd4po9WgBNRY8NrWZfwlVvjur+
         35l0tuXsDyAfovHobH4JpUVpkFYeJC6ZtPSuPtbsYl3H90P75Ktm3CXP2ftC+1rqQtkp
         S45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790186769; x=1790791569;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVBitp2ypb5rk+Duv9E+85B2/ZBqaQtfqUeJKLPpBlA=;
        b=VlutlmCN1TCvZvl/4mr/H1kml7NoJOAaEvSPY1KubLT8Wsp1ynfFDm6XnJXOmMVbQ5
         3JAqKrFBbsIgU7XdaSEgbwax1HgKp/Xuv0nBww2Evmrhbup4P8+OqtyboiCU/MeLYXtg
         AicV3ocTWT52rK4eTuRPZlcUWzlN5xXxKZinDElLF/xhehsOyXAmrVwNYlWJLZ1DOc4s
         JzUKQRwuZvGE1bmFHIicOpYafVKtN88/Fcs8AUEfSXcuw0fxfrAZoISODwc5JUtPRjoH
         r+ldLIQ53pD9XCQ0EIn5QC8H0cB4XOC08E1ZDlm3KTQXy5kq/EC55++oFwTs5g/Iw/Ms
         nPuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRhwYHIo9OjTIZhgp7r3dXtBKXLFon2/KTtLzw2FV9Y9Sdtj6Viaewcm+Q6QPzc9eL9o4=@vger.kernel.org
X-Gm-Message-State: AFuF++m9D8za66QvlmgN0WYSsFry5FM1s73qc4m08u9hY43VMl9Wlp+b
	Ai8LIyaG0b4KrqiXilGoPAOHCLd4ljH4y41IAlKPNFq1GBAe/ESV489g
X-Gm-Gg: AYBFou0VRj6TGL7XB9Tkmtp1d3djFb17ihvuG9gM4aGWrjtGltf0H3U/SsW9oXFitnK
	2yY6zBAajbsS+NdFp3js5vpHGUnGohZBrEkhTKv1H6Rhpm5+Vxk+iQ+YG/IusbW3e2VQ2SUxgtq
	m+wP639m2oeo16okp9sZOQauId+6jXebl9C4iFtuzEZOdoInmpeuRe3WET1Kj/bRuu9C4lvmruh
	NbokSS98KGzORWOaU//NEKbRzKCHBNf/EYiV6TynEsPMdDNhOsyor8JsBsdsd6GABHU8HkG3MPF
	ibTnLHEqgMEOamMRNlCWHm2gmk+w6V9mzH3dwxGrdEoKnlVYxOKST73WDDlXTfIA65+bM6/6v35
	8m4QecoFSNfFTT4pbn5aBKZv8yRnqHxWPfetth51IRXAS4Y9mtMnBbHWWApo82bVTeK8TR03bt0
	WiXGdxkWXA5GNc27KAMBtzxUm1Vbun5yY3xOZZouEJjow+8/v8qXe7xp0c7xrk+gWMuJSUUIIOG
	R96o3T0sMhc891ap2TwnuY4PTSwJG+w3zud2YwPCR6lK/fw6eCn0EtQ
X-Received: by 2002:a05:6808:199c:b0:4cb:f21c:a795 with SMTP id 5614622812f47-4d5b930b740mr4483430b6e.29.1790186769270;
        Wed, 23 Sep 2026 11:06:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c487:37ae:5ef2:4c1? ([2620:10d:c090:500::7:ac0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81604bae8cdsm3696386a34.27.2026.09.23.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:06:09 -0700 (PDT)
Message-ID: <0c312ad4f725193e714a50c5fcfc31ad2b273f7d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 11:06:07 -0700
In-Reply-To: <3469ede8-6c37-49c9-b261-d2c8506eada5@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045922.2417689-1-yonghong.song@linux.dev>
	 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
	 <3469ede8-6c37-49c9-b261-d2c8506eada5@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 10:27 -0700, Yonghong Song wrote:

...

> This patch is to avoid a verification failure. Let us say, we remove this
> patch and run the following
>    ./test_progs -t exceptions_cleanup
> and we will get the following failure:

...

> This patch intends to explore *unreachable* insns to avoid verification f=
ailure.
>
> I think due to "record =3D { begin =3D 1, end =3D 2, pad =3D 4 }", it is =
considered that the code at 'pad =3D 4'
> is not dead, but actually it does dead later so we have the above failure=
.
>
> So I add this patch to avoid failure. But maybe we should just remove thi=
s patch,
> and mark this test as failure as indeed landing pad is not reachable.
>
> WDYT?

But that's a self-fulfilling thing, the test you are pointing at looks
as follows:

 /*
  * 15. A region around a call the kernel knows cannot unwind: no call site=
 is
  * marked, nothing reaches the pad, and the sweep removes it. The program =
is
  * otherwise ordinary and has to load.
  */
 static __used __naked __noinline __u64 nounwind_rec_frame(void)
 {
         ...
 }

So, the test is added to test this cfg pass, the cfg pass is added to
make this test pass, meanwhile compiler does not generate such code.
I don't see a point, tbh.
