Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA23254A2;
	Wed, 17 Jun 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724628; cv=none; b=OESUadR9LvHYdEfeVA2cqFJNp7AQizNZz2G1Wg3qpoIQKoflsqIbToqQgrB+2p/60vtmKNmpCbuEuRh+fFeTr7f0a/iPEMpU6AzDi659yCdeTPz3/XCRm9/ub3jg35AID4sDJ7ZqFcT1flrQurcILXObHISwuKX0Y72RhgYJM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724628; c=relaxed/simple;
	bh=ZOkI/CQ5rQnypHYqI24cC37Ps1e9uNwrI86cc1swhE0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PwVAEbnTzuFh56YdRFoKuYh18+BRDn0oetQzDQUzdz1hpcNTOkwLkazA38MgVfs90qgjiiI7kW/ycFmFgX8+22B972VmBZE8cTQXy8yIDpGpgg4eJO19KqkwFVfVVoXeytW+Vqd1LsNVTm4oSKlJXlXlZ9dy7Ottfo7ow/cS59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IdT5+uw8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IdT5+uw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781724615; x=1782329415; i=markus.elfring@web.de;
	bh=kbRf9XVaoMu1loowd8qnCpl5Ta5EbRL4IpwMvHIQvsc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IdT5+uw8RBaFFpqw53bV/JkTNaBsvVaB+/vUigDxa42LIo51LWk4AzPFMRt4IcqH
	 iHjgRwfJib1bdi3m5Sfrj/N7jAcQ4MeZ41Guy+dwHjO6W2m+oCX3D3Xyp9mIJK43f
	 gf2wGzFymigsvIdTItwdKCr4xzJaMgzPcqNi0sdmjhtmqo+7bwJrC0JhilocFU72Z
	 YrZbV5Iqf8kuJOyiTO2qjoRk4V8esZPS1rk40YONp9IElP15jsNI1RKxAoMMrWsrA
	 FR3uBf/orgKGIzURQtnB+YJBHMIIoJjN5TNJ5Qsd5utGeKOukaDhH8R3fTYYa2QDX
	 cW1J+tfdG95CHCZiqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1xNCbL0RpE-014bEF; Wed, 17
 Jun 2026 21:30:15 +0200
Message-ID: <d6622225-c765-4d9f-9501-1021df4687a4@web.de>
Date: Wed, 17 Jun 2026 21:30:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bpf: Use common error handling code in bpf_is_state_visited()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eKxvDTsG3r1tswMfiX/kLho3nnpDVICVCfZZfn3TPrdMBrOShd9
 8NuHrUZrYMqbJ2x8zQnlI/5fLR1/zz+AcReraWJhhI54GVultVfX+fmHFHqSXfXsIktUww6
 CW3earLKEhVj6Hc4fJWX6RTP/7LFJTHm58Z2qnnyGMTsBTCFiAPJPJJtrLO1PQRb3ZVNR41
 0N1krgHZ3lNxFNtUzLTLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1ZqkMSvW9w=;C2Ft47s04slVWcbX5HaUfwYf2WA
 DXQEyP25O2VM2Dc7jl+rB9vd4rW/I60XPfMnxMDKaWeddA/Phe/Q5zGhRr8miP70j0Xq528JD
 ETQkK4QGx4pe92NNTlu/S+jYAfFPw1JHblBirUKlnAuRc9Az4t1oiJnilYw9lyVLetfgQbXYA
 1PLhzCQvGtFwWYNL/ye1CTj3WVqSm2+ktwgIJQvDcs1r09iHLmk6a0n3WFjsBAJMcZuPgKZt5
 KoVUrKYOoEf3zANvXaK1juVvgomGDk6XRoiXJsYvh1h5Ch6vWsdnqmq4BVRNJtIX4GTvcYVHT
 HukRkWl1Lu1CX958FtXyemLit42fs7TZwqBKDuxR6SKxulvRqCio4su6yYa5ry2P4LZt/UjC3
 pbxKfLRzhUoKE9efHv0GqoWjR56/Uo0yW+bYaf0MbiyA/7dgNc0wyJhiZ+bYf6Auh4CtWRybe
 6Jtj8lyhe1IuCw8FhCvLWJD4G1TJhY72hMGwSdMg4S23vcNHPz1WSHdWT1D+nfOcC5bKNF4U/
 MHq4PXGjFPRfsFnQWJNw7VMJNQVbrVRu/Uiov1LAcWu0IL+E39vFF/ZqLbzBPusU0RSmlah9L
 e16MXeLfcufbgVHBiTgVQeyP035PSTBaL3mRsrRQxaGQmDndy4wMQmhjiIKZ+n0ot74Tt/vxc
 Z3ZN5OlKGIRzcE923iIS6LQz9UiWPAnt9katXN6EX7CP8yhUwUbSYzn824MzAgCoe58dbxdqH
 8wk7ExvxTwJ8jjm8c92RJ3KuOtnkoT3up/KN3r0jwtIHpFdVaxPaladm4AI7uj33INursBJOX
 X657oBojdJsoUtG5gG+xE0utjj+z3tqnNcRQRoOIsvXeJZp7qW8imtPWY5C+K8+UK4CJVwE25
 6jMQ0gbcN+IHccs1xZ7k6PuzS1J3IGzEryyp+WV92i77HiYphurhOf9WzHDRBk3JrBOV/PXXi
 u3hWmCvE4HZanBa2qFxUocF4OpA051gV/zo9m+XeqOJzJotg8A5mBednoykmaNHL3VUoJJXgD
 WXtP6OpeU3HXuhHqfTwaZ4ELIj6cX3E5j4w4YdicESXjeKldiRg5f+eeeh/dpx8OTsDKxDjmD
 aEK7ii2uUzqsp6hAmmtdAcUKLyhOd2wwoJF1KBr3iiY3CpvsodzNZPiojfViXI8cNPKJgI0sh
 tvyLMlFjbamb5U05cSRMkhGW/e7/sOEy2WzrpwUuu3srzWSdXj9ZHEe6mTAEfyr8h2lZMHysU
 IdSsS1Z3lZpGdsfxaniYisNpkGCPNdTV8r7cBVahupwym64hTMSB6FrGekg3+ysVkT/ogemxc
 Ldpxvf6Y+empmPYP71U7N6u8lIM/cAv4GlQ6s3yBsDMl09neWCGN3Lan3x3e4yR7uHsyhxIOh
 oR58LdeDSQ+dN3+XI93vj5B0WiPCgHegQPFVW2SfMw3eByoFg9pEvqD0bryDTzwdk2jW1zCMS
 Ad8dq5KUY4mIYmeaBX0iu/EpKGbyUplu6z+XLtv4YpiS7lFDZHM56ZQravnm5wY+1XdFPvuUk
 7ECgcgPq+7blVrlqHe6ua2WWlu2BzTiPmuO6Akbl8ZmAuwkRes3q9/nyPJ2XI5JFx5yyK/YL1
 lCKVA5t9h7agmnDHQpAck2bJDyo/lp8OJq/Wf4nqgtnxphRxXJITXN95BhSNMIzAcR0oK6WgC
 TeGtc1cjzsbO1JB5l16e5Xyvl+vTIZHW5NTBIObZpaZJLZZoxUyIzwVVpFMZkgFjrwyJZvYTK
 zGv4ncUJCUVUdOpk4oYOH7MWHJaVyg0M6UbppH1fzkdUWzJkVCsoHGAAwvJyljZlfKKkI6zbH
 6S6G3fUDTEwXuPLE+sAbQ7h+lMu/QB2LoWJpX7qEUsIRaB2NVET0srqITcsIEyF6pI3KCS8TB
 TlZxsIHnDnAz0ZCqI1EVsbn+piyJlmPpYcQYL1zwqOrL+yYI4t54N1ev6ZiUYKTj4iAwBajsx
 sE3ICAQX0B/K4jqqmHj5cEaDeTPki71VKjkcIiQ3/TTCsVZWH9gqzorYqQfmj/EgxmvgDx0u7
 l9P0EI/6qP5vx3wZI3LHVDS1Iph44v8UznOfCjH8A+M6+jV2JNjFqbzk+hWUgOBNHIWt8DpgE
 qHWVDZOJm4oEWPRzMaybqGy4r6IgsBjlwD92zOhpKADq1roPGMM7ssojTfCSKtQV546kGPJoR
 w+stum62Lx+3E5r16rPmeW/v7cUMiOIWvYo14JOMCupbylUzoY6Dq2bagQdScFQiPqxGUrs6C
 cq8Nwqg1uDJWxDHBZrOHfnApOfeyKz3GUaEX+H7bf5L6O0e1Z4Pngw+gGQOdzQg8Ny7tHMaAE
 dZsqBnJP5Fa9NlMNLeVTPhQdEOGjP6sujkqecsn1n4cxTY0lmO8WIK2Z8Dl2Y5s96q1vouasL
 B2IrfCgzYDBspb41p5oZ6+7SxjKobF2YnamqKGftVnIHaoF/9URqaOqNcPD/4GZURfHZ0wuXW
 qmIjiCMzpt2jQPFQjT3HLWH4VPU2PNRyrJouUYiKwgOw+yIcgkX2vQKkqxvgqD4MrhkJQwimJ
 1OY33kPiqfxZ4s8mqGZ75lXmpW+QjAozOT9y7I+9AsN2XmKCYEclYoGNkw40wtYEARaYJO7/i
 z0t4MwP8fOKZd+EKaMvtYQ1sI/T1KSlNwAjS52XTLhO08l8deTvow+75Pv5AmPSeqNONCKS9U
 B8S3Ty+Xck+QptI9g5Zz8kJjgdSyqG9YLNCVy8beO/+Ajr/i3xVB8ogmPew8BAyMPsuTRssEf
 zCVLPieeIMSqFZq98y7NA0gcgAdsGeR8Y3TA5suug7g/uISTBm9Xfkl3yzsanaiCyybAvhFS3
 IAJ+karCIko0CesvDBhdQiDWcgzy4DSsmjWCfRv9WGJ11uQT5o1DTLtrmHwamBoZX158bKltj
 8cBJOxdCbX7xGU6ZoOBcHaHDpC+26xO0W2iL82BlwUU2yRaZpE1/07s5+xvE7ot7g3wHubT3Z
 SckMHyaw9h11CQcsNsMOXOD8tDOv1V4aZ49lF+dIDdbmxrXnlkMg4RTG492O0fD4IjhFlcrcB
 2Mt6F4lA8hiKEpZ3QzdPq4BAg+uub9ZheqX/oH/7ln1QE3iQZio417ORod6pLMFCDIMWz8xxf
 MCl7INE4MYCYBDErFeq+XR9uxVJaczoVeVCXqtRip/WVJMTvecPm856RmPZ7CL+uQsCDPoer0
 p0g+JTm7CLf5VQLDXCjZfny9fE4fKtMkcv/PYKtB+R5TcfwSXYyjD61tXbUCxmNXEhy89GswU
 gs6mJxCVVtHoK8Gu5g4SU5as2FqQXSXSCt6Ic4AVs4hmeVS3vBucVciBEITK7UDyqSlpnHgwj
 Hd5lFvkMzufCwMuHPkgNnDUcIR4BDzgHz84MTAYrGkCw+kQwedfMI/zig/5xp+batJDVW8G8K
 rGdylXfyviqXF/mzQxea6Q0AR9AmToaXi7OIdkxcEgnTo7WzzQ5KY5uTFVEbe+fLIUstht8YT
 YIs2IVrW4AdQbQUHjQDlOfKfaL0NVFYKQyNiF9l0rdBsEi+UXgLL5ivTAGlQI0xcsAEfHK3A6
 eLUlT6hocKu3ep7iCVkAEbGLkK5nysjPdU9IXv1zMwYKyHDCLckS9AuhdTH3DxO3Ilm6sZRLd
 C+AYCODDhso+PIhacX385YlEzgPCg7ku3eqnBrFKLjBBnUo/xYPZhH5Xq3PIJf93/YTnWnkDT
 BaxAAy6LxwR1OjST+JLVi6dnfxpkFOX0EXj6TMaOSymOdXTNWgXot7/VY4RciK+6+1bi083Bc
 /PH4DmT85WWJuxb7kwFZP2sm2sryEW/3iHZJWzYzZpgebFuGqIRNw0S2vFkMUslKx2gCRE4RM
 IJXU5p1ZopG2vk15zi8wyjpzWg49Godbq7IU6p3xQLueiwLqnqYqn7chkH/V924pX7IrBfQmF
 Dz/T9Km0q9pCfuoqTnr0pELroJmGRmcVsnHs1ZfIEbtLe1ITphOyLKR138dddr5y1mGVwWR8H
 9rzRcd41GBlNimplCOfyXjlG58t02ZJAhxgxg1o7dr4AAGRsvcVoqHMS6ViUY/euk3B37eIgv
 asG+x9SyATicg+0Stqm77aPuVoIHcSgo28+FMGB7QMEbND5OULIFvYdHGRhvpYZ2IurDE2NgT
 q6OadApgN69mO9u7pE/wl7yoz9p3QlMt0j8MC1DmwnkiZt20QfoJUWH5PQrzfkLaILmv6OwOk
 48II0j8X3qALcYJaLlwovsJSCZQl0xGKPX2B6oX2Nz4j9i/5vCpttIiSa6IdSHUNvXyigSJYz
 XR9k7Yq0wXxFFT0uIkCW6y3L1kG9R7E3SH5nHOYQZE+Gr/SRb5+4wtEGUSohSeLisLlKWYa9R
 DF6rNxovBPmBtmCUkJMR33500YVm8C87uYzy/OYI/nZrFlvRj80hUtJRoNXsNc1PUdEnyFvqY
 T6nsZgY3clf3mQp+REC6oWl/IvehW1+HydvMxdEgKZ4QzgTHa2fli5mtF2XhpBT0kwe6FMjVd
 jecZCPrUD9EgUn10c90HhGhTpvNNTJzUNxz211LtzsTuzuD908flrbqTXjzX84JYM4s+a+X5S
 G0yHAR+Z4NKarcJlTtbcWl2DX0IkMa69VYbHBRrewtKHPeyeJ9k9KeKtMMyWYiFJbJTF3Lpva
 zyqKGrly6SXj+2tkiCWmRyq7M51AnMZAY1mKtYrojK6DW3+qOS2/ArQ5jgTYWzJrjJ+FAyP4A
 l4C1Ob+rBkm0x4AD0EBwdlitzeExGe4IoQfuSyCl54HycjNBlQNWP38Qqpbc7RleJIoe+wuZN
 6HFODzsbAgzJ2BgdsELsrUi5D5JEe4X4KN/xaj9h6di4Hw9bIz2854FXkZn0Q68/oVaB7Ws+j
 6WF44mmynzF/EgnKzEzxxiO0LiqeDHgtfGS1tDjpzOdrnWfP9zf/zlemDncMZ1eCrVedbEe8P
 QkCy3ZTQ+Uf4NWn3lx1wxoaiJJ40bEZKQ4DTx/86ZCdBn470dADIh+EDEFz9oLaol0E0TfaxN
 /jDwuOGKV+C3MxCbgauS8alOndnXgj4cuDXDor/izWQ7YjhQ3G1yh2pG4R3IIAeJQQa6r35UP
 5qoLas9y3XBEfelK0RDPimFlhu+EvCABWkv8Fpl/pATN9PhOJ3ocVsHgLa5AIN3Z5XMbRrqC1
 uXXbE9y7gg8+KxbnNfeRuuLFVZdvty0ugwW7aJHjEYqMHrN6S0DOPgyiAWFK74k2yCyUcejJS
 fr6Hok5pYz+4BpkrkYjtLw+WuBLQjHlq0t7Dw7Mi5H1iMvgbs8XfcSpR34LGiwxVOkrCpiAZs
 eBeNd9NjGmLNBTeD9tRYY+RTjJYehbPAioCT12Uhi0KbSfpaH/sDKXvfVEhkmmQ6au3lAt9ya
 yqn3T3qVcABZKyXpsp+VUPaYUdV06uCpOXMzrXamIi9aLJusvPZCilg/3pTXpYayNVQBgSocz
 twwCioNjvWPiF+MHoUf4z2nTusty5mwFljkH+RGRF65iwt1wNsX3z7NqTvhdikcckQxhj1sWL
 AxgeAXqv6zEs3tyNleHFz0g9oauF1kMC0jo1nqX9MVuVL/+ouMd+yVjsqvHr7mAThkn0Ao1HF
 WM5XskqwgbiXOlFW1XoX2m1ZjCQ1/oV7TimYG/Qy5FPxldh5fabUBVReQeJA7RrxnHwlmsqjr
 YzxjjzhavgBlQFaAgM=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jun 2026 21:15:08 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/states.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..09f87e2bb1e6 100644
=2D-- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1566,21 +1566,16 @@ int bpf_is_state_visited(struct bpf_verifier_env *=
env, int insn_idx)
 	/* add new state to the head of linked list */
 	new =3D &new_sl->state;
 	err =3D bpf_copy_verifier_state(new, cur);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
+	if (err)
+		goto free_verifier_state;
+
 	new->insn_idx =3D insn_idx;
 	verifier_bug_if(new->branches !=3D 1, env,
 			"%s:branches_to_explore=3D%d insn %d",
 			__func__, new->branches, insn_idx);
 	err =3D maybe_enter_scc(env, new);
-	if (err) {
-		bpf_free_verifier_state(new, false);
-		kfree(new_sl);
-		return err;
-	}
+	if (err)
+		goto free_verifier_state;
=20
 	cur->parent =3D new;
 	cur->first_insn_idx =3D insn_idx;
@@ -1588,4 +1583,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *en=
v, int insn_idx)
 	bpf_clear_jmp_history(cur);
 	list_add(&new_sl->node, head);
 	return 0;
+
+free_verifier_state:
+	bpf_free_verifier_state(new, false);
+	kfree(new_sl);
+	return err;
 }
=2D-=20
2.54.0

