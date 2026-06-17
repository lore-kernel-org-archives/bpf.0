Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D3407CDA;
	Wed, 17 Jun 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704916; cv=none; b=kkIany571SgPVuikT1j4kAkFw6rFfv/0uWY4CN+hEagUaTTQiuAb39cpnq3LvknfgchVS7uVQy948XzdfJduiKMoboL735G+/0iH9g4nildQBCM2PR06Fq0OJr693z4lCzuhGLP2GTk310paEQh/vRqLhs1M7/p2O30UlL0tyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704916; c=relaxed/simple;
	bh=aVIqX3+SY58Zm6FgHw2cvB3Wd31JDxcEdcyQod/y4e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DJvO90keFj+S0IFd7oqOKPRaUqx/OIcu8xEeELM43/DnVwCgeI4SEvAvtrRhVmM+B8TRLNsm7TgpjMSBQEm5I6UrIoQJyYKvozlnYY+pyn2MidNI0050H5Z03cLHIqUZ5MZEYtvruMNGLSb6r2eTcsRf62ST77BR9vh1Q+UNJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Jc/IFtEG reason="signature verification failed"; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Jc/IFtEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=R0pPewL4HkezeiTmuNSpdDO
	4u/7PaTORdo2JzLu+GSU=; b=Jc/IFtEGi4/5a4i79qq+vSXB/TLGCFejUawYVQ9
	dC0koiCMtIRBkfmN+sfQynQ79jURT5ugNxo3ztX9biMS2YA8WD0RB/sv8MQk5aTq
	thfGaaAcqCUDzpBtm7lYSicwQYkdI5nRp7BctMIfFFA+k9PuYHTbTbmAplxP/AZg
	UR54=
Received: from gnq25$mails.tsinghua.edu.cn ( [59.66.19.181] ) by
 ajax-webmail-web4 (Coremail) ; Wed, 17 Jun 2026 22:01:24 +0800 (GMT+08:00)
Date: Wed, 17 Jun 2026 22:01:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Luis Gerhorst" <luis.gerhorst@fau.de>,
	"Shuah Khan" <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf 2/2] selftests/bpf: Cover stack nospec slot
 indexing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <DJAS8Y6NFDM3.2UBTXDT6CKACA@etsalapatis.com>
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <DJAS8Y6NFDM3.2UBTXDT6CKACA@etsalapatis.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <592abb4b.7e4ff.19ed5e2ff61.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:ywQGZQDX66C0qDJqfVFTAg--.34080W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYBA2oyQ815QwA
	Csr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRW1pbCBUc2FsYXBhdGlz
IiA8ZW1pbEBldHNhbGFwYXRpcy5jb20+Cj4gU2VuZCB0aW1lOldlZG5lc2RheSwgMTcvMDYvMjAy
NiAwNToxNDoxMgo+IFRvOiAiTnVvcWkgR3VpIiA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNu
PiwgIkFsZXhlaSBTdGFyb3ZvaXRvdiIgPGFzdEBrZXJuZWwub3JnPiwgIkRhbmllbCBCb3JrbWFu
biIgPGRhbmllbEBpb2dlYXJib3gubmV0PiwgIkFuZHJpaQo+ICBOYWtyeWlrbyIgPGFuZHJpaUBr
ZXJuZWwub3JnPiwgIkVkdWFyZCBaaW5nZXJtYW4iIDxlZGR5ejg3QGdtYWlsLmNvbT4sICJLdW1h
ciBLYXJ0aWtleWEgRHdpdmVkaSIgPG1lbXhvckBnbWFpbC5jb20+Cj4gQ2M6ICJKb2huIEZhc3Rh
YmVuZCIgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4sICJNYXJ0aW4gS2FGYWkgTGF1IiA8bWFy
dGluLmxhdUBsaW51eC5kZXY+LCAiTHVpcyBHZXJob3JzdCIgPGx1aXMuZ2VyaG9yc3RAZmF1LmRl
PiwgIlNodWFoCj4gIEtoYW4iIDxzaHVhaEBrZXJuZWwub3JnPiwgYnBmQHZnZXIua2VybmVsLm9y
ZywgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmIDIvMl0gc2VsZnRlc3RzL2JwZjogQ292
ZXIgc3RhY2sgbm9zcGVjIHNsb3QgaW5kZXhpbmcKPiAKPiBPbiBUdWUgSnVuIDE2LCAyMDI2IGF0
IDEyOjU3IFBNIEVEVCwgTnVvcWkgR3VpIHdyb3RlOgo+ID4gQWRkIGEgdmVyaWZpZXIgdGVzdCBm
b3IgdGhlIGZpeGVkLW9mZnNldCBzdGFjayB3cml0ZSBjYXNlIHdoZXJlIHR3byA0LWJ5dGUKPiA+
IHN0b3JlcyBpbml0aWFsaXplIG9wcG9zaXRlIGhhbHZlcyBvZiB0aGUgc2FtZSBzdGFjayBzbG90
Lgo+ID4KPiA+IFRoZSB0ZXN0IHVzZXMgdGhlIENBUF9CUEYtd2l0aG91dC1DQVBfUEVSRk1PTiBs
b2FkZXIgbGFuZSBzbyBTcGVjdHJlIHY0Cj4gPiBtaXRpZ2F0aW9uIHJlbWFpbnMgYWN0aXZlLiBJ
dCBleHBlY3RzIGJvdGggaGFsZi1zbG90IHdyaXRlcyB0byBlbWl0IG5vc3BlYwo+ID4gaW4gdGhl
IHRyYW5zbGF0ZWQgcHJvZ3JhbS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOdW9xaSBHdWkgPGdu
cTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4KPiAKPiBSZXZpZXdlZC1ieTogRW1pbCBUc2FsYXBh
dGlzIDxlbWlsQGV0c2FsYXBhdGlzLmNvbT4KPiAKPiBUcml2aWFsIHN0eWxlIG5pdHMuCj4gCj4g
PiAtLS0KPiA+ICAuLi4vdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3VucHJp
di5jICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ3MvdmVyaWZpZXJfdW5wcml2LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ3MvdmVyaWZpZXJfdW5wcml2LmMKPiA+IGluZGV4IGMxNmY4MzgyY2YxN2QuLjllYmJk
NGI1MzFkZjEgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MvdmVyaWZpZXJfdW5wcml2LmMKPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9ncy92ZXJpZmllcl91bnByaXYuYwo+ID4gQEAgLTk3Niw0ICs5NzYsMjcgQEAgbDBfJT06
CWV4aXQ7CQkJCQkJXAo+ID4gIAk6IF9fY2xvYmJlcl9hbGwpOwo+ID4gIH0KPiA+ICAKPiA+ICtT
RUMoInNvY2tldCIpCj4gPiArX19kZXNjcmlwdGlvbigibm9wZXJmbW9uOiBTcGVjdHJlIHY0IHN0
YWNrIHdyaXRlIHNsb3QgaW5kZXgiKQo+ID4gK19fc3VjY2VzcyBfX3N1Y2Nlc3NfdW5wcml2Cj4g
PiArX19jYXBzX3VucHJpdihDQVBfQlBGKQo+ID4gK19fcmV0dmFsKDApCj4gPiArI2lmZGVmIFNQ
RUNfVjQKPiA+ICtfX3hsYXRlZF91bnByaXYoInIwID0gMCIpCj4gPiArX194bGF0ZWRfdW5wcml2
KCIqKHUzMiAqKShyMTAgLTQpID0gcjAiKQo+ID4gK19feGxhdGVkX3VucHJpdigibm9zcGVjIikK
PiA+ICtfX3hsYXRlZF91bnByaXYoIioodTMyICopKHIxMCAtOCkgPSByMCIpCj4gCj4gTm8gd2hp
dGVzcGFjZSB0byB0aGUgcmlnaHQgb2YgLQo+IAo+ID4gK19feGxhdGVkX3VucHJpdigibm9zcGVj
IikKPiA+ICtfX3hsYXRlZF91bnByaXYoImV4aXQiKQo+ID4gKyNlbmRpZgo+ID4gK19fbmFrZWQg
dm9pZCBzdGFja193cml0ZV9ub3NwZWNfc2xvdF9pbmRleCh2b2lkKQo+ID4gK3sKPiA+ICsJYXNt
IHZvbGF0aWxlICgiCQkJCQlcCj4gPiArCXIwID0gMDsJCQkJCQlcCj4gPiArCSoodTMyICopKHIx
MCAtIDQpID0gcjA7CQkJXAo+ID4gKwkqKHUzMiAqKShyMTAgLSA4KSA9IHIwOwkJCVwKPiAKPiBV
bmFsaWduZWQgXCAKPiAKPiA+ICsJZXhpdDsJCQkJCQlcCj4gPiArIgk6OjogX19jbG9iYmVyX2Fs
bCk7Cj4gPiArfQo+ID4gKwo+ID4gIGNoYXIgX2xpY2Vuc2VbXSBTRUMoImxpY2Vuc2UiKSA9ICJH
UEwiOwoKVGhhbmtzLgoKSSdsbCBmaXggdGhlIHNlbGZ0ZXN0IGZvcm1hdHRpbmcgYnkgYWRkaW5n
IHRoZSBtaXNzaW5nIHdoaXRlc3BhY2UgaW4gdGhlCl9feGxhdGVkX3VucHJpdigpIHN0cmluZ3Mg
YW5kIGFsaWduaW5nIHRoZSBpbmxpbmUgYXNtICdcJyBtYXJrZXJzLgo=
